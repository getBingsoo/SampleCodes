//
//  ArticleService.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import Foundation
import Alamofire
import RxSwift

class ArticleService {

    /// RxSwift 사용: 콜백지옥 방지
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in

            self.fetchNews { result in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let articles):
                        observer.onNext(articles)
                }

                observer.onCompleted()
            }

            return Disposables.create() // 옵저버가 필요없어졌을 때 알아서 메모리에서 없애주는 친구
        }
    }

    /// 기본 사용방법.
    private func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = ""

        guard let url = URL(string: urlString) else {
            return completion(.failure(NSError(domain: "lina", code: 404, userInfo: nil)))
        }

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(.failure(error))
                }

                if let articles = response.value?.articles {
                    return completion(.success(articles))
                }
            }
    }
}
