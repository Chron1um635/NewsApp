//
//  Article.swift
//  NewsApp
//
//  Created by Максим Назаров on 05.02.2023.
//

import Foundation

struct Article: Codable {
    
    let source: Source
    let title: String
    let description: String?
    let autrhor: String?
    let url: String
    let urlToImage: String?
    var imageData: Data?
    let publishedAt: String
}
