//
//  MovieDetailsViewController.swift
//  JuanFlix
//
//  Created by Juan Dominguez on 2/19/19.
//  Copyright © 2019 Juan Dominguez. All rights reserved.
//

import UIKit
import AlamofireImage
class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        
        let size = "w185"
        let baseUrl = "https://image.tmdb.org/t/p/\(size)"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterImageView.af_setImage(withURL: posterUrl!)
        
        let backdropSize = "w780"
        let backdropBaseUrl = "https://image.tmdb.org/t/p/\(backdropSize)"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
        
        backdropImageView.af_setImage(withURL: backdropUrl!)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
