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
                print(dataDictionary)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
