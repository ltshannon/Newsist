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
    @ObservedObject public var postListMV = ArticilesListViewModel()
    
    var body: some View {
//        ZStack {
            VStack {
                VStack {
/*
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 30,height:30)
                            .padding()
//                        Spacer()
                        Text("NEWSIST")
                            .font(.custom("Big Caslon Medium", size: 60))
                        Spacer()
                    }
*/
                    Text("TRENDING")
                        .font(.custom("Avenir Bold", size: 20))
                        .foregroundColor(Color.red)
                        .padding()
                }
                List(self.postListMV.articiles, id: \.id) { post in
                    NavigationLink(destination: TrendingView(item: post.articile)) {
                        VStack(alignment: .leading) {
                            Text(post.topic)
                                .font(.custom("Avenir Bold", size: 15))
                                .foregroundColor(getTopicColor(topic: post.topic))
                            Text(post.title)
                                .font(.custom("Avenir Bold", size: 35))
                            HStack {
                                WebImage(url: URL(string:post.urlToImage))
                                    .resizable()
                                    .placeholder(Image(systemName: "photo"))
                                    .scaledToFit()
                                    .frame(width: 150, height: 150, alignment: .leading)
                                Text(post.description)
                                    .font(.custom("Avenir", size: 20))
                            }
                            StatsView(item: post.articile)
                        }
                    }
                }
            }
//            VStack {
//                Text("hello")
//            }
//                .frame(width: 100, height: 100)
//                .background(Color.gray)
//        }
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
