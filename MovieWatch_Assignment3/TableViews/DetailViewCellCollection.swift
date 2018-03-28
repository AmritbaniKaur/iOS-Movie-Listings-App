//
//  DetailViewCellCollection.swift
//  MovieWatch_Assignment3
//
//  Created by Amritbani Sondhi on 3/22/18.
//  Copyright © 2018 Amritbani Sondhi. All rights reserved.
//

import UIKit

class DetailHeader: UIView //UICollectionViewCell//UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var movie: MovieAttrInfo?
    
    let myLabel:UILabel =
    {
        let label = UILabel()
        label.text = "This is Collection View Header"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.shadowColor = UIColor.brown
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews()
    {
        
        //backgroundColor = .blue
        myLabel.backgroundColor = .clear

        addSubview(myLabel)
        
        myLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetailRatings: UIView//UICollectionViewCell//UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    //var movie: MovieAttrInfo?
    
    let ratings:UIImageView =
    {
        let img = UIImageView()
        //label.text = "Poster"
        img.image = UIImage(named: "default-movie")
        img.contentMode =  .scaleAspectFit //.scaleAspectFill //.scaleAspectFit
        //img.sizeToFit()
        img.image = UIImage(named: "default-movie")?.withAlignmentRectInsets(UIEdgeInsets(top: -15, left: 0, bottom: -5, right: 0))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    func setupViews()
    {
        ratings.backgroundColor = .clear
        //ratings.backgroundColor = .yellow
        addSubview(ratings)
        
        ratings.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ratings.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ratings.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        ratings.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    override init(frame: CGRect)
    {
        
        //CGRect frame = imageView.frame;
        //frame.size.width = 100;
        
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DetailPoster: UIView//UICollectionViewCell//UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var movie: MovieAttrInfo?
    
    let imageName:UIImageView =
    {
        let img = UIImageView()
        //label.text = "Poster"
        img.image = UIImage(named: "default-movie")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: 0, bottom: -5, right: 0))
        img.contentMode = .scaleAspectFit
        //img.bounds = CGRectInset(view.frame, 10.0f, 10.0f);
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    func setupViews()
    {
        imageName.backgroundColor = .clear
        //imageName.backgroundColor = .black

        addSubview(imageName)
        
        imageName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DetailDescriptionTitle: UIView //, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    //var movie: MovieAttrInfo?

     let overviewLabel:UILabel =
     {
         let label = UILabel()
         label.text = "Overview"
         label.font = UIFont.boldSystemFont(ofSize: 18)
         label.shadowColor = UIColor.brown
         label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
     }()
    
    func setupViews()
    {
        overviewLabel.backgroundColor = .clear

        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        overviewLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //CGRect rect = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        //overviewLabel.drawText(in: rect)
        //overviewLabel.
    }
}

class DetailDescription: UIView //, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var movie: MovieAttrInfo?

    /*
    let overviewLabel:UILabel =
    {
        let label = UILabel()
        label.text = "Overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    let overviewLabel: UITextView =
    {
        let desc = UITextView()
        desc.text = "<Description>"
        desc.contentInset = UIEdgeInsetsMake(5, 2, 5, 5)
        desc.font = UIFont(name: (desc.font?.fontName)!, size: (desc.font?.pointSize)!+1)
        //desc.insetsLayoutMarginsFromSafeArea = true
        desc.isEditable = false
        desc.translatesAutoresizingMaskIntoConstraints = false
        return desc
    }()
    
    func setupViews()
    {
        overviewLabel.backgroundColor = .clear
        //backgroundColor = .yellow
        
        addSubview(overviewLabel)
        
        overviewLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        overviewLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        overviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
}

