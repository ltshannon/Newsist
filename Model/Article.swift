//
//  Article.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit

struct Extractions: Decodable {
    let extraction: [Extraction]?
}
struct Extraction: Decodable {
    let parsed_value: String?
    let relevance: String?
}

struct NewsArticle: Decodable {
    let id: String?
    let source: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let category: String?
    let extractions: Extractions?
}

struct NewsCompany: Identifiable {
    let id: String?
    let description: String?
    let reporting: String?
    let url: String?
    let urlToImage: String?
    let reading: Int?
    let biased: String?
    let biasedCount: Int?
    let extractions: [String]?
    
    init (id: String, description: String, reporting: String, url: String, urlToImage: String, reading: Int, biased: String, biasedCount: Int, extractions: [String]) {
        self.id = id
        self.description = description
        self.reporting = reporting
        self.url = url
        self.urlToImage = urlToImage
        self.reading = reading
        self.biased = biased
        self.biasedCount = biasedCount
        self.extractions = extractions
    }
}

struct Article: Identifiable {
    let id: UUID
    let category: String?
    let title: String?
    let description: String?
    let userCount: Int?
    let coveredBy: String?
    let reportType: String?
    let url: String?
    let urlToImage: String?
    var newsCompany: [NewsCompany]
    
    init (category: String, title: String, description: String, userCount: Int, coveredBy: String, reportType: String, url: String, urlToImage: String, newsCompany: [NewsCompany]) {
        self.id = UUID()
        self.category = category
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
