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
    @State var results: [Articile] = []
    
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
                        Text(post.topic!)
                            .font(.custom("Avenir Bold", size: 15))
                            .foregroundColor(getTopicColor(topic: post.topic!))
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
                .onAppear(perform: loadData)
        }
            .navigationBarTitle("NEWSIST", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.loadData()
                }) {
                    Image(systemName: "person")
                }
            )
    }
    
    func loadData() {
        results.removeAll()
        let urlString2 = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTjtE5wLLpYSOiMS4iTNwPky38EwNPl8QlK33Jgj2JOPnDM7VmyJC-Qg2PxL6VTwHf0dsjCKG-9DD49/pub?output=tsv"
                
        guard let url = URL(string: urlString2) else {
            fatalError("Invalid URL")
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
        }

        let optionalString: String? = String(decoding: data, as: UTF8.self)
        if  let dataArr = optionalString?.components(separatedBy: "\r\n").map({ $0.components(separatedBy: "\t") })
        {
            for row in dataArr {
                if row[0] == "topic" {
                    continue
                }
                            
                var array: [NewsCompany] = []
                var c: NewsCompany
                if row[5].count > 0 {
                    c = NewsCompany.init(reporting: row[6], url: row[7], urlToImage: row[8], reading: Int(row[9])!, biased: row[10], biasedCount: row[11])
                    array.append(c)
                }
                if row[11].count > 0 {
                    c = NewsCompany.init(reporting: row[12], url: row[13], urlToImage: row[14], reading: Int(row[15])!, biased: row[16], biasedCount: row[17])
                    array.append(c)
                }
                if row[17].count > 0 {
                    c = NewsCompany.init(reporting: row[18], url: row[19], urlToImage: row[20], reading: Int(row[21])!, biased: row[22], biasedCount: row[23])
                    array.append(c)
                }
                if row[23].count > 0 {
                    c = NewsCompany.init(reporting: row[24], url: row[25], urlToImage: row[26], reading: Int(row[27])!, biased: row[28], biasedCount: row[29])
                    array.append(c)
                }
                if row[29].count > 0 {
                    c = NewsCompany.init(reporting: row[30], url: row[31], urlToImage: row[32], reading: Int(row[33])!, biased: row[34], biasedCount: row[35])
                    array.append(c)
                }
                
                let sortedArray = array.sorted {
                    $0.reading! < $1.reading!
                }
                
                let item = Articile.init(topic: row[0],
                                        title: row[1],
                                        description: row[2],
                                        userCount: row[3],
                                        coveredBy: row[4],
                                        reportType: row[6],
                                        url: row[7],
                                        urlToImage: row[8],
                                        newsCompany: sortedArray
                                        )
                self.results.append(item)
        //                    print(row)
            }
        }
    }.resume()
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
    case "Health & Living":
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
