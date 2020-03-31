//
//  Article.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit

struct UserCount: Decodable {
    let userCount: Int?
}

struct Sources: Decodable {
    let biase: Int?
    let category: String?
    let description: String?
    let name: String?
    let sourceId: String?
    let url: String?
    
    init(biase: Int, category: String, description: String, name: String, sourceId: String, url: String) {
        self.biase = biase
        self.category = category
        self.description = description
        self.name = name
        self.sourceId = sourceId
        self.url = url
    }
}

struct Extractions: Decodable {
    let extraction: [Extraction]?
}
struct Extraction: Decodable {
    let parsed_value: String?
    let relevance: String?
}

// This is the data format gotten from NewsAPI
struct NewsArticle: Decodable {
    let id: String?
    let userCount: Int?
    let source: String?
    let sourceId: String?
    let publishedAt: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let category: String?
    let extractions: Extractions?
}

struct NewsCompany: Identifiable {
    var id: String?
    var source: String?
    var sourceId: String?
    var description: String?
    var reporting: String?
    var url: String?
    var urlToImage: String?
    var reading: Int?
    var biased: String?
    var biasedCount: Int?
    var extractions: [String]?
    
    init (id: String, source: String, sourceId: String, description: String, reporting: String, url: String, urlToImage: String, reading: Int, biased: String, biasedCount: Int, extractions: [String]) {
        self.id = id
        self.source = source
        self.sourceId = sourceId
        self.description = description
        self.reporting = reporting
        self.url = url
        self.urlToImage = urlToImage
        self.reading = reading
        self.biased = biased
        self.biasedCount = biasedCount
        self.extractions = extractions
    }
    
    mutating func updateCount(count: Int) {
        reading = count
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

