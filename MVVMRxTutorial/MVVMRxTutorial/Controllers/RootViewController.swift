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

    let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
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
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }

    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            // collectionView reload
            print(articles)
        }).disposed(by: disposeBag)
    }

}
