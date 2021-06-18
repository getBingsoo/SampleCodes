//
//  MusicUseCaseNetwork.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

class MusicUseCaseNetwork: MusicUseCase {

    var service: Serviceable

    init(service: Serviceable) {
        self.service = service
    }

    func fetchMusic(completion: @escaping (Result<Music, NetworkError>) -> Void) {
        service.networkInfo.method = .get
        service.request { result in
            completion(result)
        }
    }
}
