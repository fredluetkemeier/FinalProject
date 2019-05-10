//
//  AlbumViewController.swift
//  FinalProject
//
//  Created by Fred Luetkemeier on 5/9/19.
//  Copyright © 2019 Fred Luetkemeier. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistNameLabel: UILabel!
    @IBOutlet weak var albumDateLabel: UILabel!
    @IBOutlet weak var albumGenresLabel: UILabel!
    @IBOutlet weak var albumCopyrightLabel: UILabel!
    
    var album: Album?
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let album = album {
            if let imageUrl = URL(string: album.artworkURL),
                let imageData = try? Data(contentsOf: imageUrl) {
                albumImageView.image = UIImage(data: imageData)
            }
            
            albumNameLabel.text = album.name
            albumArtistNameLabel.text = album.artistName
            
            let tempDate = dateFormatter.date(from: album.releaseDate)
            dateFormatter.dateFormat = "MMMM d, yyyy"
            albumDateLabel.text = dateFormatter.string(from: tempDate!)
            
            var genresString = ""
            let genres = album.genres
            for genre in genres {
                genresString += genre + ", "
            }
            genresString.removeLast(2)
            albumGenresLabel.text = genresString
            
            albumCopyrightLabel.text = album.copyright
            
            DispatchQueue.global(qos: .background).async {
                let artwork500Url = album.artworkURL.replacingOccurrences(of: "200x200bb.png", with: "500x500bb.png")
                var biggerImage: UIImage?
                if let biggerImageUrl = URL(string: artwork500Url),
                    let biggerImageData = try? Data(contentsOf: biggerImageUrl) {
                    biggerImage = UIImage(data: biggerImageData)
                }
                
                DispatchQueue.main.async {
                    self.albumImageView.image = biggerImage
                    print("Bigger image loaded")
                }
            }
        }
    }
}
