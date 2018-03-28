//
//  MovieTableViewController.swift
//  MovieWatch_Assignment3
//
//  Created by Amritbani Sondhi on 3/20/18.
//  Copyright © 2018 Amritbani Sondhi. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    weak var activityIndicatorView: UIActivityIndicatorView!
    
    var results: MovieResults? // Data we will use
    //var results = [MovieResults]() // Data we will use

    override func viewDidLoad()
    {
        super.viewDidLoad()

        downloadJSON
        {
            //print("JSON download successful")
            //self.tableView.reloadData()
            
        }
        
        self.tableView.reloadData()
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        tableView.backgroundView = activityIndicatorView
        //tableView.layer.shadowOpacity = 0.8;
        //tableView.layer.shadowRadius = 5.0;
        //tableView.layer.shadowOffset = CGSizeZero;
        //tableView.layer.shadowPath = [UIBezierPath bezierPathWithRect:myView.layer.bounds].CGPath;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        // add activityIndicatorView to view controller, so viewWillAppear will be called
        self.activityIndicatorView = activityIndicatorView
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //*********tableView.register(UITableViewCell.self, forCelUITableViewCellr: "cellid")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cellid")
        //tableView.allowsMultipleSelectionDuringEditing = true;

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false
        tableView.reloadData()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func downloadJSON(completed: @escaping () -> () )
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2141436cc1d11d1aa9f276be95e352c4")
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
                    self.results = try JSONDecoder().decode(MovieResults.self, from: jsondata)
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                }
                catch //let error
                {
                    //print("Error: ", error)
                    print("JSON Downloading Error!")
                }
            }
        }.resume()
    }
    
    
    
    // called before the view controller's view is about to be added to a view hierarchy and before any animations are configured for showing the view.
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //print("Came here")
        self.tableView.reloadData()
        //print("Reaches here")
        //print("Data after delete: ", self.results!.results!)

        //self.tableView.layer.shadowOffset = CGSizeMake(-10, 15);
        //self.tableView.layer.shadowOpacity = 0.8;
        //self.tableView.layer.shadowRadius = 5.0;
        
        if self.results?.results!.count == 0 || results?.results!.count == nil
        {
            activityIndicatorView.startAnimating()
            //print("Total Results (if) is: ", results?.results!.count)

            // add delay! after deadline, run the execute closure!
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                self.activityIndicatorView.stopAnimating()
                
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                self.tableView.reloadData()
            })
        }
    }
    
    
    // Table View Cell for Row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = MovieTableViewCell(style: .default, reuseIdentifier: "cellid")
        //print("Hits here!")
        
        self.downloadJSON
        {
            cell.link = self

            let movie1 = self.results?.results![indexPath.row]
            let name = movie1?.title
            cell.movieName.text = name
            //print("Id: ", self.results?.results![indexPath.row].id)
            let path = self.results?.results![indexPath.row].poster_path!
            //print("Poster Path: ", path)
            
            cell.imageView?.image = UIImage(named: "cell-background");
            
            let downloadedImage = "https://image.tmdb.org/t/p/w154/" + path!
            
            self.getImageFromWeb(downloadedImage) { (image) in
                if let image = image
                {
                    //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                    //imageView.image = image
                    //self.view.addSubview(imageView)
                    //print("JSON Image download successful")
                    cell.imageName.image = image
                } // if you use an Else statement, it will be in background
            }
        }
        return cell
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let execName = results[indexPath.section].results![indexPath.row]
        //let viewController = storyboard?.instantiateViewController(withIdentifier: execName)
        //self.navigationController?.pushViewController(viewController!, animated: true)
        //tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        
        if let movie = results?.results![indexPath.row] //as? String //results.results![indexPath.row]
        {
            self.showDetailOfMovie(movie: movie)
        }
        
    }
    
    func showDetailOfMovie(movie: MovieInfo)
    {
        let detailController = DetailViewController()
        //let detailController = DetailTableViewController()
        detailController.movie = movie
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        //return results?.results!.count
        //if let number = results?.results!.count
        //{
        //   return number
            //return results[section].results!.count //results[section].results!.count
        //}
        return 1
    }
 

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        if let number = self.results?.results?.count
        {
            return number
            //return results[section].results!.count //results[section].results!.count
        }
        return 0
    }


    
    // Height for each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let index = indexPath.row
            print("------------------------Line 1---------------------------------")
            //self.tableView.beginUpdates()
            print("------------------------Line 2---------------------------------")
            //var dataToDelete = results?.results!
            print("---------------------added line 8----------------------------------")
            self.results?.results!.remove(at: index) //.remove(at: indexPath.row) // <------ exception thrown
            //results!.results!.remove(at: inde)
            //print("Data after delete: ", results!.results!)
            print("------------------------Line 3---------------------------------")
            //self.tableView.endUpdates()
            
            
            print("---------------------added line 6----------------------------------")
            //tableView.beginUpdates()
            //self.tableView.reloadInputViews()
            //self.tableView.reloadRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            //viewWillAppear(true)
            //self.tableView(tableView: self.tableView, cellForRowAt: indexPath)
            
            print("---------------------added line 7----------------------------------")
            //tableView.deleteRows(at: [indexPath], with: .fade) // <------ exception thrown
            print("------------------------Line 4---------------------------------")
            //self.tableView.endUpdates()
            print("------------------------Line 5---------------------------------")
        }
    }



}
extension UILocalizedIndexedCollation {
    //func for partition array in sections
    func partitionObjects(array:[AnyObject], collationStringSelector:Selector) -> ([AnyObject], [String]) {
        
        var unsortedSections = [[AnyObject]]()
        //1. Create a array to hold the data for each section
        for _ in self.sectionTitles {
            unsortedSections.append([]) //appending an empty array
        }
        //2. Put each objects into a section
        for item in array {
            let index:Int = self.section(for: item, collationStringSelector:collationStringSelector)
            unsortedSections[index].append(item)
        }
        
        //print(unsortedSections)
        
        //3. sorting the array of each sections
        var sectionTitles = [String]()
        var sections = [AnyObject]()
        for index in 0 ..< unsortedSections.count {
            if unsortedSections[index].count > 0 {
                sectionTitles.append(self.sectionTitles[index])
                sections.append(self.sortedArray(from: unsortedSections[index], collationStringSelector: collationStringSelector) as AnyObject)
            }
        }
        return (sections, sectionTitles)
    }
}
