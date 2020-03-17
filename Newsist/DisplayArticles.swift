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
                            .foregroundColor(getTopicColor(topic: post.category!))
                        Text(post.title!)
                            .font(.custom("Avenir Bold", size: 35))
                        HStack {
                            WebImage(url: URL(string:post.urlToImage!))
                                .resizable()
                                .placeholder(Image(systemName: "photo"))
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .leading)
                            Text(post.description!)
                                .font(.custom("Avenir", size: 20))
                        }
                        StatsView(item: post)
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
        
        var urlString1 = "https://us-central1-articiles.cloudfunctions.net/articiles"
//        let urlString2 = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTjtE5wLLpYSOiMS4iTNwPky38EwNPl8QlK33Jgj2JOPnDM7VmyJC-Qg2PxL6VTwHf0dsjCKG-9DD49/pub?output=tsv"
                
        guard let url = URL(string: urlString1) else {
            fatalError("Invalid URL")
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let articles = try? JSONDecoder().decode([NewsArticle].self, from: data)
            
            if let arrayOfArticles = articles {
                print("Number of acticles: \(arrayOfArticles.count)")
                var healthArray: [NewsCompany] = []
                var businessArray: [NewsCompany] = []
                var healthSources = Set<String>()
                var businessSources = Set<String>()
                var array: [NewsCompany] = []
                var c: NewsCompany
                var healthExtractions = [String:Int]()
                var businessExtractions = [String:Int]()

                for art in arrayOfArticles {
                    let description = art.description != nil ? art.description! : ""
                    let source = art.source != nil ? art.source! : ""
                    let url = art.url != nil ? art.url! : ""
                    let urlToImage = art.urlToImage != nil ? art.urlToImage! : ""
//                let description = art.description != nil ? art.description! : ""

                    var extractArray: [String] = []
                    if let extractions = art.extractions {
                        if let extraction = extractions.extraction {
                            for  extraction in extraction {
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

                    c = NewsCompany.init(id: art.id!, description: description, reporting: source, url: url, urlToImage: urlToImage, reading: Int.random(in: 1..<500), biased: getBiase(), biasedCount: Int.random(in: 1..<500), extractions: extractArray)

                    switch art.category {
                        case "Health":
                            healthArray.append(c)
                            if source.count > 0 {
                                healthSources.insert(source)
                            }
//                            healthExtractions
                        case "Business":
                            businessArray.append(c)
                            if source.count > 0 {
                                businessSources.insert(source)
                            }
                        default:
                            array.append(c)
                    }
                }
            
                if healthSources.count > 0 {
print("Health extractions: \(healthExtractions)")
                    var newArray: [NewsCompany] = []
                    
                    let topic = self.findTopic(array: healthArray, extractions: healthExtractions, newArray: &newArray)
                    print("Number of health acticles: \(newArray.count)")
                    let sourceStr = "\(healthSources.removeFirst()), + \(healthSources.count)"
                
                    if newArray.count > 0 {
                        self.buildArticleArray(category: "Health",
                                               title: topic,
                                               description: newArray[0].description ?? "",
                                               source: sourceStr,
                                               url: newArray[0].url ?? "",
                                               urlToImage:  newArray[0].urlToImage ?? "",
                                               array: newArray)
                    }
                }
            
                if businessSources.count > 0 {
print("Business extractions: \(businessExtractions)")
                    var newArray: [NewsCompany] = []
                    
                    let topic = self.findTopic(array: businessArray, extractions: businessExtractions, newArray: &newArray)
                    print("Number of business acticles: \(newArray.count)")
                    let sourceStr = "\(businessSources.removeFirst()), + \(businessSources.count)"
                    if newArray.count > 0 {
                        self.buildArticleArray(category: "Business",
                                               title: topic,
                                               description: newArray[0].description ?? "",
                                               source: sourceStr,
                                               url: newArray[0].url ?? "",
                                               urlToImage: newArray[0].urlToImage ?? "",
                                               array: newArray)
                    }
                }
            }
            
            urlString1 = "https://us-central1-deletearticles.cloudfunctions.net/GetNewsSource"
            
            guard let url2 = URL(string: urlString1) else {
                fatalError("Invalid URL")
            }
            
            URLSession.shared.dataTask(with: url2) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                print(data)
                
            }.resume()
            
            
        }.resume()
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
        print(listExtract)
        
        for item in listExtract {
            if item.value >= array.count/3 {
                returnValue.append(item.key)
                if returnValue.count >= 4 {
                    break
                }
            }
        }
        
        print(returnValue)
        
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

    func buildArticleArray(category: String, title: String, description: String, source: String, url: String, urlToImage: String, array: [NewsCompany]) {
        
        let sortedArray = array.sorted {
            $0.reading! < $1.reading!
        }
        
        let item = Article.init(category: category,
                                title: title,
                                description: description,
                                userCount: Int.random(in: 1..<500),
                                coveredBy: source,
                                reportType: getBiase(),
                                url: url,
                                urlToImage: urlToImage,
                                newsCompany: sortedArray
                                )
        self.results.append(item)
    }
    
}

func getBiase()-> String {
    
    let randomInt = Int.random(in: 1..<4)
    
    switch randomInt {
        case 1:
            return "Least Biased"
        case 2:
            return "Balanced"
        case 3:
            return "Most Biased"
        default:
            return ""
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
