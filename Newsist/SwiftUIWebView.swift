//
//  SwiftUIWebView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/2/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import WebKit
import Combine

struct ActivityIndicator: UIViewRepresentable {
    @ObservedObject public var indicator: changeIndicator
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.indicator.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

class changeIndicator: ObservableObject {
    @Published var shouldAnimate = true

}

struct SwiftUIWebView: UIViewRepresentable {
    let url: String
    @ObservedObject var indicator: changeIndicator
    
    let webView = WKWebView()

    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        
        if let url = URL(string: url) {
            self.webView.load(URLRequest(url: url))
        }
       
        return self.webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var indicator: changeIndicator

        init(_ indicator: changeIndicator) {
            self.indicator = indicator
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //print("WebView: navigation finished")
            self.indicator.shouldAnimate = false
        }
    }

    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(indicator)
    }
}
