//
//  PlayerController.swift
//  Cognera
//
//  Created by DHEERAJ BHAVSAR on 08/06/19.
//  Copyright © 2019 Dheeraj Bhavsar. All rights reserved.
//

import Foundation
import AVFoundation

class PlayerController {
    
    static let shared  = PlayerController()
    
    var player: AVPlayer?
    
    init() {
        player = AVPlayer()
    }
    
    func playItem(at url: URL) {
        let item = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: item)
    }
}
