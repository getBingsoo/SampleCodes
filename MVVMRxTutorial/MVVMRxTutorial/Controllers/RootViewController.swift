//
//  RootViewController.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import UIKit
import RxSwift
import RxRelay // RxCocoa 설치하면 같이 딸려오는애. articles를 subscribe하기 위해서

class RootViewController: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()

    let viewModel: RootViewModel

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        cv.delegate = self
        cv.dataSource = self

        cv.backgroundColor = .systemBackground
        return cv
    }()

//    let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
//    var articleViewModelObservable: Observable<[ArticleViewModel]> {
//        return articleViewModel.asObservable()
//    }

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
        configureUI()
        configureCollectionView()
        fetchArticles()
        subscribe()
    }

    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground

        self.title = self.viewModel.title

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureCollectionView() {
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
    }

    // MARK: Helpers
//    func fetchArticles() {
//        // 서비스에서 받은거 구독!!
//        // 구독하여 onNext에서 뷰 업데이트 해주면 될 것 같다.
//        // 근데 여기서는 받아온걸 다시 relay에 전달한다.
//        // 그럼 relay를 구독하는 놈이 받는건데
//        // 여기서는 relay를 직접 구독하지 않고 relay를 옵저버블로 만들어서 이걸 바로 아래에서 구독하네
//        // relay는 전달용도로만 사용된듯하다.
//        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
//            self.articleViewModel.accept(articleViewModels) // 전달(next와 동일한 효과)
//        }).disposed(by: disposeBag)
//    }
//
//    func subscribe() {
//        // 1. 리팩토링 - subscribe
////        self.articleViewModel.subscribe(onNext: { articles in
////            // collectionView reload
////            DispatchQueue.main.async {
////                self.collectionView.reloadData()
////            }
////        }).disposed(by: disposeBag)
//
//        self.articleViewModelObservable.subscribe(onNext: { articles in
//            // collectionView reload
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }).disposed(by: disposeBag)
//    }
//

    // MARK: My Helpers 내가 구현해본것들

    var articles: [Article] = []

    func fetchArticles() {
        viewModel.fetchArticles()
    }

    func subscribe() {
        viewModel.articles?.subscribe(onNext: { articles in
            self.articles = articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension RootViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return articleViewModel.value.count
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell

        cell.imageView.image = nil // 초기화 꼭 필요

//        let articleViewModel = self.articleViewModel.value[indexPath.row]
        let article = articles[indexPath.row]
        cell.subject.onNext(article)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

}
