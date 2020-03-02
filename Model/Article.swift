//
//  Article.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit

struct Articile: Decodable {
    
    let id: UUID?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let topic: String?
    
}

