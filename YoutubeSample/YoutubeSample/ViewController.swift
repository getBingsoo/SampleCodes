//
//  ViewController.swift
//  YoutubeSample
//
//  Created by Lina Choi on 2020/11/19.
//  Copyright © 2020 anil. All rights reserved.
//

import youtube_ios_player_helper
import UIKit

class ViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
//        playerView.load(withPlaylistId: "bsM1qdGAVbU")
        playerView.load(withVideoId: "bsM1qdGAVbU", playerVars: ["playsinline": 1])
        
        let otherPlayer = YTPlayerView()
        view.addSubview(otherPlayer)
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

