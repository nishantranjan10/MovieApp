//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by NISHANT RANJAN on 8/3/22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var searchList: Search? {
        didSet {
            setPosterImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = MovieConstant.movieImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setPosterImage() {
        
        if let urlString = self.searchList?.Poster {
            DispatchQueue.main.async {
                self.imageView.loadThumbnail(urlString: urlString)
            }
        }
    }
}
