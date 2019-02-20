//
//  MoviesViewController.swift
//  JuanFlix
//
//  Created by Juan Dominguez on 2/12/19.
//  Copyright © 2019 Juan Dominguez. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // array of dictionaries (individual movies)
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        // get array of movies and put it into dataDictionary
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try!
                    JSONSerialization.jsonObject(with: data, options: [])
                    as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.moviesTableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "MovieTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        // ?/! indicates the optional
        cell.titleLabel!.text = title
        cell.synopsisLabel.text = synopsis
        
        let size = "w185"
        let baseUrl = "https://image.tmdb.org/t/p/\(size)"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
    
        cell.posterImageView.af_setImage(withURL: posterUrl!)
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation
 */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
        // find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = moviesTableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        
        moviesTableView.deselectRow(at: indexPath, animated: true)
        
        // pass the movie to the details view controller
    }
 

}
