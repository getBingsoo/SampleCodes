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

    func fetchArticles() -> Observable<[Article]> {
        return articleService.fetchNews()
    }
}
