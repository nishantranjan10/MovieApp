//
//  MovieListCell.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 4/3/22.
//

import Foundation
import UIKit

class MovieListCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var searchList: Search? {
        didSet {
            
            if let title = searchList?.Title {
                self.titleLabel.text = "Title : \(title)"
            }
            
            if let type = searchList?.type {
                self.typeLabel.text = "Type : \(type)"
            }
            
            if let year = searchList?.Year {
                self.yearLabel.text = "Year : \(year)"
            }
            
            self.movieImage.loadThumbnail(urlString: searchList?.Poster ?? "")
        }
    }
}
