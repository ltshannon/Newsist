//
//  ContentView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

var articiles: [Articile]?

struct ContentView: View {
    @State var selectedView = 1
//    @ObservedObject public var postListMV = ArticilesListViewModel()
       
    var body: some View {

        TabView(selection: $selectedView) {
            Text("Coming soon")
                .tabItem {
                    Image("newspaper")
                    Text("My Topics")
                }.tag(0)
            NavigationView {
                DisplayArticles()
            }
                .tabItem {
                    Image("trending")
                    Text("Trending")
                }.tag(1)
            Text("Coming soon")
                .tabItem {
                    Image("browse")
                    Text("Browse")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
