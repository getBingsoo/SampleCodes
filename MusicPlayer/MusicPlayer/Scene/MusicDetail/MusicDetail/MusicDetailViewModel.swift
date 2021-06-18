//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import UIKit
import AVKit

protocol ViewModel {

}

class MusicDetailViewModel: ViewModel {

    var music: Music?
    var player: AVPlayer?
    var vc: MusicDetailViewController?

    func fetchMusic() {
        // todo
        let networkInfo = NetworkInfo(method: .get)
        let musicNetwork = MusicUseCaseNetwork(service: MusicService(networkInfo: networkInfo))

        musicNetwork.fetchMusic() { [weak self] result in
            switch result {
                case .success(let music):
                    self?.music = music

                    if let url = URL(string: music.file) {
                        let playerItem = AVPlayerItem(url: url)
                        self?.player = AVPlayer(playerItem: playerItem)
                        self?.player?.play()
                    }

                    DispatchQueue.main.async {
                        self?.vc?.displayMusicView(music: music)
                    }
                case .failure(let error):
                    print(error) // todo
            }
        }
    }
}
