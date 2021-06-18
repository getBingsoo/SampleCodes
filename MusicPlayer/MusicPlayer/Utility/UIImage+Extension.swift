//
//  UIImage+Extension.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/19.
//

import UIKit

extension UIImageView {

    func loadImage(from url: URL) {
        self.image = nil

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription) // todo: delete
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
