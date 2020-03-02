//
//  WebService.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import Foundation
import SwiftUI

class WebService {
    
    func getPostData(competion: @escaping ([Articile]?) -> ()) {
        
        guard let url = URL(string: "https://us-central1-articiles.cloudfunctions.net/articiles") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    competion(nil)
                }
                return
            }
            let articiles = try? JSONDecoder().decode([Articile].self, from: data)
            DispatchQueue.main.async {
                competion(articiles)
            }
        }.resume()
    }
    
}
