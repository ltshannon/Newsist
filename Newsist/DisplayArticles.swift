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
//    @ObservedObject var postListMV = ArticilesListViewModel()
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
                    c = NewsCompany.init(reporting: row[5], url: row[6], urlToImage: row[7], reading: row[8], biased: row[9], biasedCount: row[10])
                    array.append(c)
                }
                if row[11].count > 0 {
                    c = NewsCompany.init(reporting: row[11], url: row[12], urlToImage: row[13], reading: row[14], biased: row[15], biasedCount: row[16])
                    array.append(c)
                }
                if row[17].count > 0 {
                    c = NewsCompany.init(reporting: row[17], url: row[18], urlToImage: row[19], reading: row[20], biased: row[21], biasedCount: row[22])
                    array.append(c)
                }
                if row[23].count > 0 {
                    c = NewsCompany.init(reporting: row[23], url: row[24], urlToImage: row[25], reading: row[26], biased: row[27], biasedCount: row[28])
                    array.append(c)
                }
                if row[29].count > 0 {
                    c = NewsCompany.init(reporting: row[29], url: row[30], urlToImage: row[31], reading: row[32], biased: row[33], biasedCount: row[34])
                    array.append(c)
                }
                            
                let item = Articile.init(topic: "World",
                                        title: row[0],
                                        description: row[1],
                                        userCount: row[2],
                                        coveredBy: row[3],
                                        reportType: row[4],
                                        url: row[6],
                                        urlToImage: row[7],
                                        newsCompany: array
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
