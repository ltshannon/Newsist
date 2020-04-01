//
//  BNODetailView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/31/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct BNODetailView: View {
    let url: String
    
    var body: some View {
        WebView(request: url)
    }
}

struct BNODetailView_Previews: PreviewProvider {
    static var previews: some View {
        BNODetailView(url: "https://www.apple.com")
    }
}
