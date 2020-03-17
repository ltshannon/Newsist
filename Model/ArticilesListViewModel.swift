//
//  ArticilesListViewModel.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import Foundation

class ArticilesListViewModel: ObservableObject {
    @Published var articles = [PostViewModel]()
    
    init() {
        WebService().getPostData { posts in
            if let posts = posts {
                self.articles = posts.map(PostViewModel.init)
            }
        }
    }
    
    func refresh() {
        
        articles.removeAll()
        
        WebService().getPostData { posts in
            if let posts = posts {
                self.articles = posts.map(PostViewModel.init)
            }
        }
    }
}

struct PostViewModel {
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var id: UUID {
        return UUID()
    }
    
    var title: String {
        if let title = self.article.title {
            return title
        }
        return ""
    }
    
    var description: String {
        if let description = self.article.description {
            return description
        }
        return ""
    }
    
    var url: String {
        if let url = self.article.url {
            return url
        }
        return ""
    }
    
    var urlToImage: String {
        if let urlToImage = self.article.urlToImage {
            return urlToImage
        }
        return ""
    }
    
    var category: String {
        if let category = self.article.category {
            return category
        }
        return ""
    }
}
