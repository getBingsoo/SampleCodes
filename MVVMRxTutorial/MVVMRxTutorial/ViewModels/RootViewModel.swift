//
//  RootViewModel.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "Lina News"

    private let articleService: ArticleServiceProtocol

    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }

    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { articles in
            articles.map { article in
                ArticleViewModel(article: article)
            }
        }
    }

}
