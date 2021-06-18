//
//  Music.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

struct Music: Codable {
    let singer: String
    let album: String
    let title: String
    let duration: Int
    let image: String
    let file: String
    let lyrics: String
}
