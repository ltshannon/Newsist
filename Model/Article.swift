//
//  Article.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit
/*
struct Articile: Decodable {
    
    let id: UUID?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let topic: String?
    
}
*/
struct NewsCompany: Decodable {
    let id: UUID?
    let reporting: String?
    let url: String?
    let urlToImage: String?
    let reading: String?
    
    init (reporting: String, url: String, urlToImage: String, reading: String) {
        self.id = UUID()
        self.reporting = reporting
        self.url = url
        self.urlToImage = urlToImage
        self.reading = reading
    }
}

struct Articile {
    
    let topic: String?
    let title: String?
    let description: String?
    let userCount: String?
    let coveredBy: String?
    let reportType: String?
    let url: String?
    let urlToImage: String?
    let newsCompany: [NewsCompany]
    
    init (topic: String, title: String, description: String, userCount: String, coveredBy: String, reportType: String, url: String, urlToImage: String, newsCompany: [NewsCompany]) {

        self.topic = "World"
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
