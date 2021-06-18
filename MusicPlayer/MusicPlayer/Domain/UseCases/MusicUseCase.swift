//
//  MusicUseCase.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

protocol MusicUseCase {
    func fetchMusic(completion: @escaping (Result<Music, NetworkError>) -> Void)
}
