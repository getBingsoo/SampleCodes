//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import UIKit

protocol ViewModel {

}

class MusicDetailViewModel: ViewModel {

    var music: Music?
    var vc: MusicDetailViewController?

    func fetchMusic() {
        // todo
        let networkInfo = NetworkInfo(url: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json", method: .get)
        let musicNetwork = MusicUseCaseNetwork(service: MusicService(networkInfo: networkInfo))

        musicNetwork.fetchMusic() { [weak self] result in
            switch result {
                case .success(let music):
                    self?.music = music
                    DispatchQueue.main.async {
                        self?.vc?.displayMusicView(music: music)
                    }
                case .failure(let error):
                    print(error) // todo
            }
        }
    }
}
