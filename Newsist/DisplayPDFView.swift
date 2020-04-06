//
//  DisplayPDFView.swift
//  Newsist
//
//  Created by Larry Shannon on 4/3/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFKitView : UIViewRepresentable {
    var urlString: String
    
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()

        let str = "https://www.sandiegocounty.gov" + urlString
        guard let url = URL(string: str) else {
            fatalError("Invalid URL")
        }
        
        pdfView.document = PDFDocument(url: url)

        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Empty
    }
    
}

struct DisplayPDFView: View {
    var url: String
    
    var body: some View {
        
        VStack {
            PDFKitView(urlString: url)
        }
    }
}

struct displayPDFView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPDFView(url: "")
    }
}
