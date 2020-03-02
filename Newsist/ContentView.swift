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
    @State var isNavigationBarHidden: Bool = true
        
    var body: some View {
        NavigationView {
            TabView {
                FirstView()
                    .tabItem {
                        Image("newspaper")
                        Text("My Topics")
                    }.tag(0)
                Text("Second View")
                    .tabItem {
                        Image("trending")
                        Text("Trending")
                    }.tag(1)
                Text("Thrid View")
                    .tabItem {
                        Image("browse")
                        Text("Browse")
                    }.tag(2)
            }
            .navigationBarTitle("Title")
            .hideNavigationBar()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
