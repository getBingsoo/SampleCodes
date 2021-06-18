//
//  MusicService.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

class MusicService: Serviceable {

    let url: String = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json"
    var networkInfo: NetworkInfo

    init(networkInfo: NetworkInfo) {
        self.networkInfo = networkInfo
    }

    func request<T>(completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let request = networkInfo.makeRequest(url: self.url) else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return completion(.failure(.parsingError))
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.parsingError))
            }

        }.resume()
    }
}
