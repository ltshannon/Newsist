//
//  StatsView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/3/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    let item: Articile
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image("fire")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("\(item.userCount!) users reading")
            }
            HStack {
                Image("world")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Covered by \(item.coveredBy!)")
            }
            HStack {
                Image("head")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Reporting is \(item.reportType!)")
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(item: Articile(topic: "test", title: "test", description: "test", userCount: "test", coveredBy: "test", reportType: "test", url: "test", urlToImage: "test", newsCompany: []))
    }
}
