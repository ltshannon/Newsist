//
//  Article.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit

struct NewsArticle: Decodable {
    
    let id: UUID?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let topic: String?
    
}

struct NewsCompany: Identifiable {
    let id: UUID?
    let reporting: String?
    let url: String?
    let urlToImage: String?
    let reading: Int?
    let biased: String?
    let biasedCount: String?
    
    init (reporting: String, url: String, urlToImage: String, reading: Int, biased: String, biasedCount: String) {
        self.id = UUID()
        self.reporting = reporting
        self.url = url
        self.urlToImage = urlToImage
        self.reading = reading
        self.biased = biased
        self.biasedCount = biasedCount
    }
}

struct Articile: Identifiable {
    let id: UUID?
    let topic: String?
    let title: String?
    let description: String?
    let userCount: String?
    let coveredBy: String?
    let reportType: String?
    let url: String?
    let urlToImage: String?
    var newsCompany: [NewsCompany]
    
    init (topic: String, title: String, description: String, userCount: String, coveredBy: String, reportType: String, url: String, urlToImage: String, newsCompany: [NewsCompany]) {
        self.id = UUID()
        self.topic = "U.S. POLITICS"
        self.title = title
        self.description = description
        self.userCount = userCount
        self.coveredBy = coveredBy
        self.reportType = reportType
        self.url = url
        self.urlToImage = urlToImage
        self.newsCompany = newsCompany
    }
}
