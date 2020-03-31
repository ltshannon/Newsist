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
    let userCountId: String
    var companies: NewsCompanies
    
    @ObservedObject var indicator = changeIndicator()
    @Environment(\.presentationMode) var presentation
        
    var body: some View {
        VStack {
                
//            ActivityIndicator(indicator: indicator)
            SwiftUIWebView(url: url, indicator: indicator)

//            WebView(request: url)
        }
        .onAppear(perform: self.incrementUserCount)
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image("chevron-right")
            }
        )
    }
    
    func incrementUserCount() {
                        
        let urlString = "https://us-central1-deletearticles.cloudfunctions.net/updateUserCount?docId=\(userCountId)"
    print(urlString)
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
                
            if let count = try? JSONDecoder().decode(UserCount.self, from: data) {
    print(count)
                if let c = count.userCount {
                    DispatchQueue.main.async {
                        self.companies.incrementUserCount(userCountId: self.userCountId, count: c)
                    }
                }
            }
                        
        }.resume()
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(url: "https://www.apple.com", userCountId: "https://www.apple.com", companies: NewsCompanies())
    }
}
