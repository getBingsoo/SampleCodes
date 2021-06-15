//
//  Article.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String?
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let author: String
    let title: String
    let description: String
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
