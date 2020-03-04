//
//  TrendingView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/3/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct TrendingView: View {
    let item: Articile
    
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        return Form {
            Section(header: VStack(alignment: .center, spacing: 0)  {
                VStack {
                    Text("STORY")
                        .font(.custom("Big Caslon Medium", size: 40))
                    Spacer()
                    Text(item.topic!)
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.red)
                        .frame(height: 10)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }) {
                EmptyView()
            }.padding([.top], -6)
            Section {
                VStack(alignment: .leading) {
                    Text(item.title!)
                        .font(.title)
                    HStack {
                        WebImage(url: URL(string:item.urlToImage!))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .leading)
                        Text(item.description!)
                            .font(.subheadline)
                    }
                    StatsView(item: item)
                }
            }
            Section {
                List(item.newsCompany, id: \.id) { details in
                    NavigationLink(destination: DetailedView(url: details.url!)) {
                        VStack(alignment: .leading) {
                            Text(details.reporting!)
                                .fontWeight(.heavy)
                            Text("\(details.reading!) users reading")
                        }
                    }
                }
            }
        }
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {

        TrendingView(item: Articile(topic: "test", title: "test", description: "test", userCount: "test", coveredBy: "test", reportType: "test", url: "test", urlToImage: "test", newsCompany: []))

    }
}
