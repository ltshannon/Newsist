//
//  ArticilesListViewModel.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import Foundation

class ArticilesListViewModel: ObservableObject {
    @Published var articiles = [PostViewModel]()
    
    init() {
        WebService().getPostData { posts in
            if let posts = posts {
                self.articiles = posts.map(PostViewModel.init)
            }
        }
    }
    
    func refresh() {
        
        articiles.removeAll()
        
        WebService().getPostData { posts in
            if let posts = posts {
                self.articiles = posts.map(PostViewModel.init)
            }
        }
    }
}

struct PostViewModel {
    var articile: Articile
    
    init(articile: Articile) {
        self.articile = articile
    }
    
    var id: UUID {
        return UUID()
    }
    
    var title: String {
        if let title = self.articile.title {
            return title
        }
        return ""
    }
    
    var description: String {
        if let description = self.articile.description {
            return description
        }
        return ""
    }
    
    var url: String {
        if let url = self.articile.url {
            return url
        }
        return ""
    }
    
    var urlToImage: String {
        if let urlToImage = self.articile.urlToImage {
            return urlToImage
        }
        return ""
    }
    
    var topic: String {
        if let topic = self.articile.topic {
            return topic
        }
        return ""
    }
}
