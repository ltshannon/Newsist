//
//  WebView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/10/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import WebKit
  
struct WebView : UIViewRepresentable {
    let request: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let url = URL(string: request) {
            uiView.load(URLRequest(url: url))
        }

    }
   
}
  
#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: "https://www.apple.com")
    }
}
#endif  
