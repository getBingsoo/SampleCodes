//
//  ArticleViewModel.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import Foundation

class ArticleViewModel {
    private let article: Article

    var imageUrl: String? {
        return article.urlToImage
    }

    var title: String? {
        return article.title
    }

    var description: String? {
        return article.description
    }

    init(article: Article) {
        self.article = article
    }
}
