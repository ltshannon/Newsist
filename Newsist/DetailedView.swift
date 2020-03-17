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
//    @ObservedObject var indicator = changeIndicator()
    @Environment(\.presentationMode) var presentation
        
    var body: some View {
        VStack {
//            ActivityIndicator(indicator: indicator)
//            SwiftUIWebView(url: url, indicator: indicator)
            WebView(request: url)
        }
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image("chevron-right")
            }
        )
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(url: "https://www.apple.com")
    }
}
