//
//  DisplayArticles.swift
//  Newsist
//
//  Created by Larry Shannon on 3/2/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct DisplayArticles: View {
    @State var results: [Article] = []
    @State var sources: [Sources] = []
    @State var firstTimeFlag = false
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia", size: 30)!]
    }
    
    var body: some View {

        VStack {
            VStack {
                Text("TRENDING")
                    .font(.custom("Avenir Bold", size: 20))
                    .foregroundColor(Color.red)
                    .padding()
            }

            List(self.results, id: \.id) { post in
                NavigationLink(destination: TrendingView(item: post)) {
                    VStack(alignment: .leading) {
                        Text(post.category!)
                            .font(.custom("Avenir Bold", size: 15))
                            .foregroundColor(getTopicColor(topic: post.category != nil ? post.category! : ""))
                        Text(post.title!)
                            .font(.custom("Avenir Bold", size: 35))
                        HStack {
                            WebImage(url: URL(string: post.urlToImage!))
                                .resizable()
                                .placeholder(Image(systemName: "photo"))
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .leading)
                            Text(post.description != nil ? post.description! : "")
                                .font(.custom("Avenir", size: 20))
                        }
//                        StatsView(item: post, userCount: self.userCount)
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image("fire")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(post.userCount!) users reading")
                            }
                            HStack {
                                Image("world")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Covered by \(post.coveredBy!)")
                            }
                            HStack {
                                Image("head")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Reporting is \(post.reportType!)")
                            }
                        }
                    }
                }
            }
                .onAppear(perform: loadFirstTime)
        }
            .navigationBarTitle("NEWSIST", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.loadArticleData()
                }) {
                    Image(systemName: "person")
                }
            )
    }
    
    func loadFirstTime() {
        if !firstTimeFlag {
            loadArticleData()
            firstTimeFlag = true
        }
    }
    
    func loadArticleData() {
        
        results.removeAll()
        sources.removeAll()
        
        let urlString1 = "https://us-central1-deletearticles.cloudfunctions.net/GetNewsSource"
         
         guard let url1 = URL(string: urlString1) else {
             fatalError("Invalid URL")
         }
         
         URLSession.shared.dataTask(with: url1) { data, response, error in
             guard let data = data, error == nil else {
                 return
             }
            
            if let sourceData = try? JSONDecoder().decode([Sources].self, from: data) {
                self.processSources(sourceData: sourceData)
            }

            let urlString2 = "https://us-central1-articiles.cloudfunctions.net/articiles"
                
            guard let url2 = URL(string: urlString2) else {
                fatalError("Invalid URL")
            }
                
            URLSession.shared.dataTask(with: url2) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
            
                if let articles = try? JSONDecoder().decode([NewsArticle].self, from: data) {
                    self.processArticles(articles: articles)
                }
            
            }.resume()
            
        }.resume()
    }
    
    func processSources(sourceData: [Sources]) {
        
        for source in sourceData {
            let s = Sources.init(biase: source.biase != nil ? source.biase! : 99,
                                 category: source.category != nil ? source.category! : "",
                                 description: source.description != nil ? source.description! : "",
                                 name: source.name != nil ? source.name! : "",
                                 sourceId: source.sourceId != nil ? source.sourceId! : "",
                                 url: source.url != nil ? source.url! : "")
            sources.append(s)
        }
    }
    
    func processArticles(articles: [NewsArticle]) {
        
//("Number of acticles: \(articles.count)")
        var healthArray: [NewsCompany] = []
        var businessArray: [NewsCompany] = []
        var healthSources = Set<String>()
        var businessSources = Set<String>()
        var array: [NewsCompany] = []
        var c: NewsCompany
        var healthExtractions = [String:Int]()
        var businessExtractions = [String:Int]()
        var userCountHealth = 0
        var userCountBusiness = 0

        for art in articles {
            let source = art.source != nil ? art.source! : ""

            var extractArray: [String] = []
            if let extraction = art.extractions?.extraction {
                for  extraction in extraction {
                    if let str = extraction.relevance {
                        let relevance = (str as NSString).floatValue
                        if relevance > 0.8 {
                            if let value = extraction.parsed_value {
                                switch art.category {
                                    case "Health":
                                        self.createHashExtraction(extractions: value, hash: &healthExtractions)
                                    case "Business":
                                        self.createHashExtraction(extractions: value, hash: &businessExtractions)
                                    default:
                                        print("createHashExtraction not called")
                                }
                                extractArray.append(value)
                            }
                        }
                    }
                }
            }

            c = NewsCompany.init(id: art.id != nil ? art.id! : "",
                                 source: art.source != nil ? art.source! : "",
                                 sourceId: art.sourceId != nil ? art.sourceId! : "",
                                 description: art.description != nil ? art.description! : "",
                                 reporting: art.source != nil ? art.source! : "",
                                 url: art.url != nil ? art.url! : "",
                                 urlToImage: art.urlToImage != nil ? art.urlToImage! : "",
                                 reading: art.userCount != nil ? art.userCount! : 0,
                                 biased: getBiase(sourceId: art.sourceId != nil ? art.sourceId! : ""),
                                 biasedCount: Int.random(in: 1..<500),
                                 extractions: extractArray)

            var count = 0
            if let temp = art.userCount {
                count = temp
            }
            switch art.category {
                case "Health":
                    healthArray.append(c)
                    if source.count > 0 {
                        healthSources.insert(source)
                    }
                    userCountHealth += count
                case "Business":
                    businessArray.append(c)
                    if source.count > 0 {
                        businessSources.insert(source)
                    }
                    userCountBusiness += count
                default:
                    array.append(c)
            }
        }
                    
        if healthSources.count > 0 {
//print("Health extractions: \(healthExtractions)")
            var newArray: [NewsCompany] = []
                            
            let topic = self.findTopic(array: healthArray, extractions: healthExtractions, newArray: &newArray)
//print("Number of health acticles: \(newArray.count)")
            let sourceStr = "\(healthSources.removeFirst()), + \(healthSources.count)"
                        
            if newArray.count > 0 {
                self.buildArticleArray(category: "Health",
                                       title: topic,
                                       description: newArray[0].description ?? "",
                                       source: sourceStr,
                                       url: newArray[0].url ?? "",
                                       urlToImage:  newArray[0].urlToImage ?? "",
                                       sourceId: newArray[0].sourceId != nil ? newArray[0].sourceId! : "",
                                       userCount: userCountHealth,
                                       array: newArray)
            }
        }
                    
        if businessSources.count > 0 {
//print("Business extractions: \(businessExtractions)")
            var newArray: [NewsCompany] = []
                            
            let topic = self.findTopic(array: businessArray, extractions: businessExtractions, newArray: &newArray)
//print("Number of business acticles: \(newArray.count)")
            let sourceStr = "\(businessSources.removeFirst()), + \(businessSources.count)"
            if newArray.count > 0 {
                self.buildArticleArray(category: "Business",
                                       title: topic,
                                       description: newArray[0].description ?? "",
                                       source: sourceStr,
                                       url: newArray[0].url ?? "",
                                       urlToImage: newArray[0].urlToImage ?? "",
                                       sourceId: newArray[0].sourceId != nil ? newArray[0].sourceId! : "",
                                       userCount: userCountBusiness,
                                       array: newArray)
            }
        }
    }
    
    func getBiase(sourceId: String) -> String {
        
        for item in sources {
            if let id = item.sourceId {
                if id == sourceId {
                    if let biase = item.biase {
                        switch biase {
                        case 1:
                            return "Least Biased"
                        case 2:
                            return "Balanced"
                        case 3:
                            return "Most Biased"
                        default:
                            return "N/A"
                        }
                    }
                    break
                }
            }
        }
        
        return ""
        
    }
    
    func createHashExtraction(extractions: String, hash: inout [String:Int]) {
        
        let array = extractions.lowercased().components(separatedBy: " ")
        
        for str in array {
            if var value = hash[str] {
                value += 1
                hash[str] = value
            }
            else {
                hash[str] = 1
            }
        }
        
    }
    
    func findTopic(array: [NewsCompany], extractions: [String:Int], newArray: inout [NewsCompany])-> String {
        
        var returnValue: [String] = []
        let listExtract = extractions.sorted(by: { $0.value > $1.value })
//print(listExtract)
        
        for item in listExtract {
            if item.value >= array.count/3 {
                returnValue.append(item.key)
                if returnValue.count >= 4 {
                    break
                }
            }
        }
        
//print(returnValue)
        
        for art in array {
            if let arrayExtractions = art.extractions {
//                let combinedResult = arrayExtractions.contains(where: returnValue.contains)
                for key in returnValue {
                    let filteredStrings = arrayExtractions.filter({(item: String) -> Bool in
                        let stringMatch = item.lowercased().range(of: key.lowercased())
                        return stringMatch != nil ? true : false
                    })
                    
                    if (filteredStrings as NSArray).count > 0 {
                        newArray.append(art)
                        break;
                    }
                }
            }
        }
        
        var returnStr: String = ""
        var first = true
        for item in returnValue {
            if first {
                returnStr = item.uppercased()
                first = false
            }
            else {
                returnStr += ", \(item.uppercased())"
            }
        }
        
        return returnStr
 /*
        if let key = extractions.first(where: { $0.value == extractions.values.max() })?.key {
            print(key)
            for art in array {
                if let arrayExtractions = art.extractions {
                    let filteredStrings = arrayExtractions.filter({(item: String) -> Bool in
                        let stringMatch = item.lowercased().range(of: key.lowercased())
                        return stringMatch != nil ? true : false
                    })
                    
                    if (filteredStrings as NSArray).count > 0 {
                        newArray.append(art)
                    }
                }
            }
            return key
        }
        return ""
 */

    }

    func buildArticleArray(category: String, title: String, description: String, source: String, url: String, urlToImage: String, sourceId: String, userCount: Int,  array: [NewsCompany]) {
        
        let sortedArray = array.sorted {
            $0.reading! < $1.reading!
        }
        
        let item = Article.init(category: category,
                                title: title,
                                description: description,
                                userCount: userCount,
                                coveredBy: source,
                                reportType: getBiase(sourceId: sourceId),
                                url: url,
                                urlToImage: urlToImage,
                                newsCompany: sortedArray
                                )
        self.results.append(item)
    }
    
}

func getTopicColor(topic: String)-> Color {
    
    switch topic {
    case "World":
        return Color.red
    case "Arts & Culture":
        return Color.orange
    case "Business":
        return Color.blue
    case "Health":
        return Color.green
    case "Science & Technology":
        return Color.purple
    case "Sports":
        return Color.black
    case "U.S. POLITICS":
        return Color.purple
    default:
        return Color.gray
    }
    
}

struct DisplayArticles_Previews: PreviewProvider {
    static var previews: some View {
        DisplayArticles()
    }
}
