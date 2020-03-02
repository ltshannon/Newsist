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
    @ObservedObject private var postListMV = ArticilesListViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Image("account-outline")
                            .resizable()
                            .frame(width: 30,height:30)
                            .padding()
                        Spacer()
                        Text("NEWSIST")
                            .font(.custom("Big Caslon Medium", size: 40))
                        Spacer()
                    }
                    Text("TRENDING")
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.red)
                        .frame(height: 10)
                }
                List(self.postListMV.articiles, id: \.id) { post in
                    NavigationLink(destination: DetailedView(url: post.url)) {
                        VStack(alignment: .leading) {
                            Text(post.topic)
                                .font(.headline)
                                .padding()
                                .foregroundColor(getTopicColor(topic: post.topic))
                            Text(post.title)
                                .font(.title)
                            HStack {
                                WebImage(url: URL(string:post.urlToImage))
                                    .resizable()
                                    .placeholder(Image(systemName: "photo"))
                                    .scaledToFit()
                                    .frame(width: 150, height: 150, alignment: .leading)
                                Text(post.description)
                                    .font(.subheadline)
                            }
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    Image("fire")
                                        .resizable()
                                        .frame(width: 20,height:20)
                                    Text("1,504 users reading")
                                }
                                HStack {
                                    Image("world")
                                        .resizable()
                                        .frame(width: 20,height:20)
                                    Text("Covered by CNN, Fox News + 30")
                                }
                                HStack {
                                    Image("head")
                                        .resizable()
                                        .frame(width: 20,height:20)
                                    Text("Reporting is balanced")
                                }
                            }
                        }
                    }
                }
            }
            VStack {
                Text("hello")
            }
                .frame(width: 100, height: 100)
                .background(Color.gray)
        }
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
    default:
        return Color.gray
    }
    
}

struct DisplayArticles_Previews: PreviewProvider {
    static var previews: some View {
        DisplayArticles()
    }
}
