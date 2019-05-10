//
//  AlbumsTableViewController.swift
//  FinalProject
//
//  Created by Fred Luetkemeier on 5/9/19.
//  Copyright © 2019 Fred Luetkemeier. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albums: [Album]?
    let jsonURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJson(albumHandler: { albumArray, error in
            if let albumArray = albumArray {
                self.albums = albumArray
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func loadJson(albumHandler: @escaping ([Album]?, Error?) -> Void) {
        guard let url = URL(string: jsonURL) else {
            print("Error: Bad URL")
            return
        }
        
        var albumArray = [Album]()
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
            
            if let root = jsonResponse as? [String: Any] {
                if let feed = root["feed"] as? [String: Any] {
                    if let results = feed["results"] as? [Dictionary<String, Any>] {
                        for item in results {
                            albumArray.append(Album(item))
                        }
                        
                        albumHandler(albumArray, nil)
                    }
                }
            }
            
            
        })
        
        task.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        
        if let cell = cell as? AlbumsTableViewCell, let album = albums?[indexPath.row] {
            if let imageUrl = URL(string: album.artworkURL),
                let imageData = try? Data(contentsOf: imageUrl) {
                cell.albumImageView.image = UIImage(data: imageData)
            }
            
            cell.albumNameLabel.text = album.name
            cell.albumArtistNameLabel.text = album.artistName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAlbumSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AlbumViewController,
            let indexPath = tableView.indexPathForSelectedRow,
        
            let album = albums?[indexPath.row] {
            destination.album = album
        }
    }

}
