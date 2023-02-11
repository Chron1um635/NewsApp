//
//  APIResponse.swift
//  NewsApp
//
//  Created by Максим Назаров on 05.02.2023.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}
