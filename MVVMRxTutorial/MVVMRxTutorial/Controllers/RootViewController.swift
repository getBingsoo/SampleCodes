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

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        cv.delegate = self
        cv.dataSource = self

        cv.backgroundColor = .systemBackground
        return cv
    }()

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
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }

    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            // collectionView reload
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }

}

extension RootViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModel.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell

        cell.imageView.image = nil // 초기화 꼭 필요

        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

}
