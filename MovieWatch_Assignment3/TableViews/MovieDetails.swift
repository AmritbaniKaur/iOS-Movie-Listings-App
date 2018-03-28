//
//  MovieDetails.swift
//  MovieWatch_Assignment3
//
//  Created by Amritbani Sondhi on 3/20/18.
//  Copyright © 2018 Amritbani Sondhi. All rights reserved.
//

import UIKit
import Foundation

struct MovieInfo: Decodable
{
    let id: Int?
    let poster_path: String? //CNContact
    let title: String?
}

struct MovieResults: Decodable
{
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    var results: [MovieInfo]?
    
    private enum CodingKeys: String, CodingKey
    {
        case page, total_results, total_pages, results
    }
}

/*
struct ImageResults: Decodable
{
    let imageDetails: String?
}
*/



