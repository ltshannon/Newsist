//
//  DetailedView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/2/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct DetailedView: View {
    let url: String
    @State var shouldAnimate = true
        
    var body: some View {
            
        VStack {
                
            Text("testing....")
//            ActivityIndicator(indicator: self.indicator)
//            WebView(url: url).edgesIgnoringSafeArea(.all)
//            SwiftUIWebView(indicator: indicator)
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(url: "https://www.apple.com")
    }
}
