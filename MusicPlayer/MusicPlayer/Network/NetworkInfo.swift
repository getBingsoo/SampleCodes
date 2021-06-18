//
//  NetworkInfo.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

struct NetworkInfo {

    var param: Any?
    var method: HttpMethod

    func makeRequest(url: String) -> URLRequest? {

        let method = self.method
        switch method {
            case .get:
                var components = URLComponents(string: url)

                if let param = self.param as? URLQueryEncodable {
                    let data = param.encode()
                    components?.queryItems = data
                } else {
                    components?.queryItems = nil
                }

                var request = URLRequest(url: components!.url!)
                request.httpMethod = self.method.toString()
                return request

            case .post:
                guard let param = self.param as? Encodable else { return nil }
                guard let data = param.encode() else { return nil }

                guard let url = URL(string: url) else { return nil }
                var request = URLRequest(url: url)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = self.method.toString()
                request.httpBody = data

                return request
        }
    }
}
