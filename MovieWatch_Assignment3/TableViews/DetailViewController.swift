//
//  DetailViewController.swift
//  MovieWatch_Assignment3
//
//  Created by Amritbani Sondhi on 3/21/18.
//  Copyright © 2018 Amritbani Sondhi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController //UICollectionViewController //UIViewController
{
    var movieResults: MovieAttrInfo? // Data we will use
    let headerId = "headerId"
    let posterId = "posterId"
    let descId = "descriptionId"
    
    let header: DetailHeader =
    {
        let header = DetailHeader()
        return header
    }()

    let ratings: DetailRatings =
    {
        let rtg = DetailRatings()
        return rtg
    }()
    
    let poster: DetailPoster =
    {
        let poster = DetailPoster()
        return poster
    }()

    let overviewTitle: DetailDescriptionTitle =
    {
        let oviewTitle = DetailDescriptionTitle()
        return oviewTitle
    }()
    
    let overview: DetailDescription =
    {
        let desc = DetailDescription()
        return desc
    }()

    
    var movie: MovieInfo?
    {
        didSet
        {
            let id = movie?.id

            let link = "https://api.themoviedb.org/3/movie/" + String(id!) + "?api_key=2141436cc1d11d1aa9f276be95e352c4"
            
            downloadJSON(link: link)
            {
            // Download details of a selected movie with id
                let movie = self.movieResults //.belongs_to_collection![0]
                print("movie: ", movie)
                print("Name from MovieAttrInfo: ", movie?.original_title!)
                
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        print("Reaches viewWillAppear")
        
        setupViews()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews()
    {

        //view.backgroundColor = .white
        //[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backdrop1"))
        view.contentMode = .scaleToFill;
        
        ////////////////////////////////////////////////////////////////////////////
        // Header
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true 
        header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        //header.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        header.heightAnchor.constraint(equalToConstant: 30.0)
        header.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        header.myLabel.text = self.movieResults?.original_title
        header.setupViews()
        
        ////////////////////////////////////////////////////////////////////////////
        // Ratings
        view.addSubview(ratings)
        ratings.translatesAutoresizingMaskIntoConstraints = false
        ratings.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        ratings.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //ratings.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        ratings.heightAnchor.constraint(equalToConstant: 30.0)
        //ratings.widthAnchor.constraint(equalToConstant: 15.0)
        ratings.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        //ratings.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        //ratings.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        
        ratings.ratings.image = getImage()
        ratings.setupViews()
        ratings.backgroundColor = .clear
        
        ////////////////////////////////////////////////////////////////////////////
        // Poster
        view.addSubview(poster)
        poster.movie = movieResults
        poster.translatesAutoresizingMaskIntoConstraints = false
        
        poster.topAnchor.constraint(equalTo: ratings.bottomAnchor).isActive = true
        poster.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        //poster.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        poster.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        //poster.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        poster.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        //poster.centerXAnchor.constraint(equalTo: ratings.centerXAnchor).isActive = true
        //poster.centerYAnchor.constraint(equalTo: ratings.centerYAnchor).isActive = true
        
        var path = self.movieResults?.backdrop_path
        var downloadedImage = ""
        if path != nil
        {
            downloadedImage = "https://image.tmdb.org/t/p/w342/" + String(path!)
        //let downloadedImage = "https://api.themoviedb.org/3/movie/337167/images?api_key=2141436cc1d11d1aa9f276be95e352c4" + movieId!
        }
        self.getImageFromWeb(downloadedImage) { (image) in
            if let image = image
            {
                //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                //imageView.image = image
                //self.view.addSubview(imageView)
                //print("JSON Image download successful")
                self.poster.imageName.image = image
            } // if you use an Else statement, it will be in background
        }
        
        poster.setupViews()
        poster.backgroundColor = .clear
        
        ////////////////////////////////////////////////////////////////////////////
        // Overview Title
        view.addSubview(overviewTitle)
        //overviewTitle.movie = movieResults
        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        
        overviewTitle.topAnchor.constraint(equalTo: poster.bottomAnchor).isActive = true
        overviewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        overviewTitle.heightAnchor.constraint(equalToConstant: 30.0)
        //overviewTitle.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        overviewTitle.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        overviewTitle.overviewLabel.text = "About the Movie"
        overviewTitle.setupViews()
        overviewTitle.backgroundColor = .clear
        
        ////////////////////////////////////////////////////////////////////////////
        // Overview
        view.addSubview(overview)
        overview.movie = movieResults
        overview.translatesAutoresizingMaskIntoConstraints = false
        
        overview.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        overview.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        overview.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        overview.overviewLabel.text = self.movieResults?.overview!
        overview.setupViews()
        overview.backgroundColor = .clear
    }
    
    func getImage() -> UIImage
    {
        let rating = self.movieResults?.vote_average
        var imageName = UIImage(named: "default-rating")
        
        if rating != nil
        {
            if Double(rating!) > Double(9.1)
            {
                imageName = UIImage(named: "image-5.0")!
            }
            else if Double(rating!) > Double(8.1) && Double(rating!) <= Double(9.0)
            {
                imageName = UIImage(named: "image-4.5")!
            }
            else if Double(rating!) > Double(7.1) && Double(rating!) <= Double(8.0)
            {
                imageName = UIImage(named: "image-4.0")!
            }
            else if Double(rating!) > Double(6.1) && Double(rating!) <= Double(7.0)
            {
                imageName = UIImage(named: "image-3.5")!
            }
            else if Double(rating!) > Double(5.1) && Double(rating!) <= Double(6.0)
            {
                imageName = UIImage(named: "image-3.0")!
            }
            else if Double(rating!) > Double(4.1) && Double(rating!) <= Double(5.0)
            {
                imageName = UIImage(named: "image-2.5")!
            }
            else if Double(rating!) > Double(3.1) && Double(rating!) <= Double(4.0)
            {
                imageName = UIImage(named: "image-2.0")!
            }
            else if Double(rating!) > Double(2.1) && Double(rating!) <= Double(3.0)
            {
                imageName = UIImage(named: "image-1.5")!
            }
            else if Double(rating!) > Double(1.1) && Double(rating!) <= Double(2.0)
            {
                imageName = UIImage(named: "image-1.0")!
            }
            else if Double(rating!) >= Double(0.0) && Double(rating!) <= Double(1.0)
            {
                imageName = UIImage(named: "image-0.5")!
            }
        }
        //let myThumb1 = myPicture.resized(withPercentage: 0.1)
        let myThumb = imageName?.resized(toWidth: 120.0)
        
        return myThumb!
    }
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ())
    {
        guard let url = URL(string: urlString) else {
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("no response")
                return closure(nil)
            }
            guard data != nil else {
                print("no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(UIImage(data: data!))
            }
        }; task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func downloadJSON(link: String, completed: @escaping () -> () )
    {
        let url = URL(string: link) //"https://api.themoviedb.org/3/movie/popular?api_key=2141436cc1d11d1aa9f276be95e352c4")
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, err) in
            if err == nil
            {
                // check downloaded JSON data
                guard let jsondata = data else
                {
                    print("Error: ", err!)
                    completed()
                    return
                }
                
                do
                {
                    self.movieResults = try JSONDecoder().decode(MovieAttrInfo.self, from: jsondata)
                    DispatchQueue.main.async
                    {
                            completed()
                    }
                }
                catch let error
                {
                    print("Error: ", error)
                    print("JSON Downloading Error!")
                }
            }
            }.resume()
    }
}

extension UIImage
{
    func resized(withPercentage percentage: CGFloat) -> UIImage?
    {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer
        {
            UIGraphicsEndImageContext()
            
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage?
    {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer
        {
            UIGraphicsEndImageContext()
            
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
