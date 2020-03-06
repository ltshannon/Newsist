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
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        UITableView.appearance().backgroundColor = .clear
        return Form {
            Section(header: VStack(alignment: .center, spacing: 0)  {
                VStack {
                    Text(item.topic!)
                        .font(.custom("Avenir Bold", size: 20))
                        .foregroundColor(Color.red)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }) {
                EmptyView()
            }.padding([.top], -6)
            Section {
                VStack(alignment: .leading) {
                    Text(item.title!)
                        .font(.custom("Avenir Bold", size: 35))
                    HStack {
                        WebImage(url: URL(string:item.urlToImage!))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .leading)
                        Text(item.description!)
                            .font(.custom("Avenir", size: 20))
                    }
                    StatsView(item: item)
                }
            }
            Section {
                List(item.newsCompany, id: \.id) { details in
                    NavigationLink(destination: DetailedView(url: details.url!)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(details.reporting!)
                                    .fontWeight(.heavy)
                                Text("\(details.reading!) users reading")
                            }
                            Spacer()
                            Image(details.biased!)
                                .scaledToFit()
                                .frame(width: 10, height: 10, alignment: .trailing)
                            if details.biasedCount != nil {
                                    Text("+\(details.biasedCount!)")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("STORY", displayMode: .inline)
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
            }
        )
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {

        TrendingView(item: Articile(topic: "test", title: "test", description: "test", userCount: "test", coveredBy: "test", reportType: "test", url: "test", urlToImage: "test", newsCompany: []))

    }
}
