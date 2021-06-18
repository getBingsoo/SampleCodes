//
//  MusicDetailViewController.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import UIKit

class MusicDetailViewController: UIViewController {

    var viewModel: MusicDetailViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!

    init(viewModel: MusicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        // todo: 없애기
        viewModel.vc = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        titleLabel.text = "aaa"
        fetchMusic()
    }

    func configureUI () {
        view.backgroundColor = .white // 이거 안써주면 배경 안바뀜
    }

    private func fetchMusic() {
        // todo 개선
        viewModel?.fetchMusic()
    }

    func displayMusicView(music: Music) {
        self.titleLabel.text = music.title
    }
}

