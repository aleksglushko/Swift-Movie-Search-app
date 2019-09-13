//
//  HomeViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 06.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    var searchBar = UISearchBar()
    var logoutButton = UIButton()
    var tableView = UITableView()
    var movies: [NSDictionary]?
    
    var moviesIdsGenres = [28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]
    
    var moviesGenresIds = ["Action": "28", "Adventure": "12", "Animation": "16", "Comedy": "35", "Crime": "80", "Documentary": "99", "Drama": "18", "Family": "10751", "Fantasy": "14", "History": "36", "Horror": "27", "Music": "10402", "Mystery": "9648", "Romance": "10749", "Science Fiction": "878", "TV Movie": "10770", "Thriller": "53", "War": "10752", "Western": "37"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get data from omdb and set the movie list
        fetchMovies(response: "")
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        // set searchbar
        self.searchBar.frame = CGRect(x: 130, y: 60, width: self.view.frame.width - 130, height: 50)
        self.searchBar.placeholder = " Search..."
        self.searchBar.layer.cornerRadius = 4
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.delegate = self
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        // set table view
        self.tableView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height)
        self.tableView.backgroundColor = UIColor.white
        // self.tableView.separatorColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        }
    
    // translate ids to genres
    func idsToGenres(ids: [Int]) -> String{
        var genresString = ""
        let cntr = 0
        let maxId = 2
        for id in ids{
            genresString = genresString + "\(moviesIdsGenres[id]!) "
            if cntr > maxId {
                break
            }
        }
        
        return genresString
    }

    // translate genres to ids
    func genresToIds(genres: String) -> String{
        var genresIds = ""
        
        let genresArr = genres.components(separatedBy: " ")
        for genre in genresArr {
            genresIds += "\(String(describing: moviesGenresIds[genre])),"
        }
        //genresIds.dropLast()
        
        return genresIds
    }

    func searchBar (_ searchBar: UISearchBar, textDidChange textSearched: String){
        if self.searchBar.text == nil || self.searchBar.text! == ""{
            let movieGenres = ""
            fetchMovies(response: movieGenres)
            tableView.reloadData()
        } else {
            //let movieGenresString = self.searchBar.text!
            let movieGenresIds = moviesGenresIds[self.searchBar.text!] 
            // set different urls for different response
            if movieGenresIds != nil {
                fetchMovies(response: movieGenresIds!)
                tableView.reloadData()
            }
            
        }
    }
    
    func fetchMovies(response: String){
        
        let apiKey = "d372b5fd608c81066dbd0892b2faeb35"
        
        var url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        if response != "" {
            url = NSURL(string: "https://api.themoviedb.org/3/discover/movie?page=1&with_genres=\(response)&sort_by=popularity.desc&language=en-US&api_key=\(apiKey)")
        }
        let request = NSURLRequest(
            url: url! as URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(
            with: request as URLRequest, completionHandler: {
                (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options: []) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
            }
        )
        task.resume()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unable to create cell")}
        let movie = movies![indexPath.row]
        // set Image, title, year, rating and genre
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        let title = movie["title"]! as? String
        
        let rate = movie["vote_average"]
        let rateString = "IMDb Rate: \(rate!)"
        
        let genre = movie["genre_ids"]! as! [Int]
        let genreSting = idsToGenres(ids: genre)
        
        cell.movieImage.setImageWith(imageUrl as! URL)
        cell.titleLabel.text = title
        cell.rateLabel.text = rateString
        cell.genreLabel.text = genreSting
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieVC = MoviePageViewController()
        
        let movie = movies![indexPath.row]
        let title = movie["title"]! as? String
        
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        let rate = movie["vote_average"]
        
        let overview = "About:\n\n\(movie["overview"])" as NSString
        let attributedString = NSMutableAttributedString(string: overview as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16.0)])
        
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        attributedString.addAttributes(boldFontAttribute, range: overview.range(of: "About:"))
                
        movieVC.movieImageView.setImageWith(imageUrl as! URL)
        movieVC.movieTitle = "  \(title!)"
        movieVC.rateLabel.text = "  IMDb Rate: \(rate!)"
        movieVC.aboutMovie.attributedText = attributedString
        movieVC.movieID = "\(movie["id"]!)"
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(movieVC, animated: true)
        
        
    }    
}
