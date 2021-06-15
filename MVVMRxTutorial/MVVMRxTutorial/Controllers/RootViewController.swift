//
//  RootViewController.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import UIKit
import RxSwift
import RxRelay // RxSwift 설치하면 같이 딸려오는애. articles를 subscribe하기 위해서

class RootViewController: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()
    
    let viewModel: RootViewModel

    private let articles = BehaviorRelay<[Article]>(value: []) // 여기에 담는다. RxRelay
    var articlesObserver: Observable<[Article]> { // articles 구독하기 위함
        return articles.asObservable()
    }

    // MARK: LifeCycles
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuerUI()
        fetchArticles()
        subscribe()
    }

    // MARK: Configures
    func configuerUI() {
        view.backgroundColor = .systemBackground
    }

    // MARK: Helpers
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articles in
            print(articles)
            self.articles.accept(articles) // articles 넣어줌
        }).disposed(by: disposeBag)
    }

    func subscribe() {
        // 값이 변화할 때 articles를 받아와서 reload
        self.articlesObserver.subscribe(onNext: { articles in
            // collectionView reload
        }).disposed(by: disposeBag)
    }
    
}
