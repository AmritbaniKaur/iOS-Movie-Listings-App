//
//  MovieTableViewCellCollection.swift
//  MovieWatch_Assignment3
//
//  Created by Amritbani Sondhi on 3/20/18.
//  Copyright © 2018 Amritbani Sondhi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell
{
    // link between table view row cell and table view controller
    var link: MovieTableViewController?
    
    let movieName:UILabel =
    {
        let label = UILabel()
        label.text = "<MovieName>"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let imageName:UIImageView =
    {
        let img = UIImageView()
        //img.image = UIImage(named: "default-movie")
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "default-movie")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: 0, bottom: -5, right: 0))
        //img.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    /*
    let rating:UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    
    /*
     // update the image of stars
     let ratingButton: UIButton = {
     let button = UIButton(type: .system)
     button.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
     button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
     
     button.tintColor = .red
     
     return button
     }()
     */
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupViews()
    {
        addSubview(movieName)
        addSubview(imageName)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-28-[v0]-8-[v1(80)]-15-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": movieName, "v1": imageName]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": movieName]))
        
        //addSubview(imageName)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": movieName]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageName]))
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
        // to set/reset favorite flag
        //favoriteButton.addTarget(self, action: #selector(tappedFavoriteButton), for: .touchUpInside)
        //accessoryView = favoriteButton
    }
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
}
