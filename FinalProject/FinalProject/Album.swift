//
//  Album.swift
//  FinalProject
//
//  Created by Fred Luetkemeier on 5/9/19.
//  Copyright © 2019 Fred Luetkemeier. All rights reserved.
//

import Foundation

struct Album {
    var name: String
    var artistName: String
    var artworkURL: String
    var copyright: String
    var releaseDate: String
    var genres = [String]()
    
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.artistName = dictionary["artistName"] as? String ?? ""
        self.artworkURL = dictionary["artworkUrl100"] as? String ?? ""
        self.copyright = dictionary["copyright"] as? String ?? ""
        self.releaseDate = dictionary["releaseDate"] as? String ?? ""
        
        if let genres = dictionary["genres"] as? [Dictionary<String, Any>] {
            for item in genres {
                self.genres.append(item["name"] as? String ?? "")
            }
        }
    }
}
