//
//  ViewController.swift
//  Cognera
//
//  Created by DHEERAJ BHAVSAR on 07/06/19.
//  Copyright © 2019 Dheeraj Bhavsar. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: BaseViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    //MARK:- IBOutlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    var itemUrl: URL?
    var item: AVPlayerItem?
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Setup Player
    func setupPlayer() {
        if let url = itemUrl {
            item = AVPlayerItem(url: url)
            
            item!.addObserver(self, forKeyPath: PlayerItemState.playbackBufferEmpty.rawValue, options: .new, context: nil)
            item!.addObserver(self, forKeyPath: PlayerItemState.playbackLikelyToKeepUp.rawValue, options: .new, context: nil)
            item!.addObserver(self, forKeyPath: PlayerItemState.playbackBufferFull.rawValue, options: .new, context: nil)
            
            player = AVPlayer(playerItem: item)
            
            self.player!.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new, .initial], context: nil)
            self.player!.addObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem.status), options:[.new, .initial], context: nil)
            
            NotificationCenter.default.addObserver(self, selector:#selector(newErrorLogEntry(_:)), name: .AVPlayerItemNewErrorLogEntry, object: player!.currentItem)
            NotificationCenter.default.addObserver(self, selector:#selector(failedToPlayToEndTime(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: player!.currentItem)
        } else {
            playButton.isEnabled = false
        }
    }
    
    @objc func finishedPlaying(_ notification: Notification) {
        playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        let playerItem: AVPlayerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: .zero, completionHandler: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if let _: AVPlayer = object as? AVPlayer, keyPath == #keyPath(AVPlayer.currentItem.status) {
            let newStatus: AVPlayerItem.Status
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItem.Status(rawValue: newStatusAsNumber.intValue)!
            } else {
                newStatus = .unknown
            }
            
            if newStatus == .failed {
                showDialog(title: "Error", actionTitle: "Okay", message:ErrorMessages.fileError)
                playButton.isEnabled = false
                indicator.isHidden = true
                debugPrint("Error: \(String(describing: self.player?.currentItem?.error?.localizedDescription)), error: \(String(describing: self.player?.currentItem?.error))")
            }
        }
        
        if object is AVPlayerItem {
            switch keyPath {
            case PlayerItemState.playbackBufferEmpty.rawValue:
                indicator.isHidden = false
                break
            case PlayerItemState.playbackLikelyToKeepUp.rawValue:
                indicator.isHidden = true
                break
            case PlayerItemState.playbackBufferFull.rawValue:
                indicator.isHidden = true
                break
            default:
                break
            }
        }
    }
    
    @objc func newErrorLogEntry(_ notification: Notification) {
        guard let object = notification.object, let playerItem = object as? AVPlayerItem else {
            return
        }
        guard let errorLog: AVPlayerItemErrorLog = playerItem.errorLog() else {
            return
        }
        showDialog(title: "Error", actionTitle: "Okay", message: errorLog.description)
        debugPrint(errorLog)
    }
    
    @objc func failedToPlayToEndTime(_ notification: Notification) {
        if let error = notification.userInfo!["AVPlayerItemFailedToPlayToEndTimeErrorKey"] as? Error {
            showDialog(title: "Error", actionTitle: "Okay", message: error.localizedDescription)
            debugPrint(error)
        }
    }

    //MARK:- IBActions
    @IBAction func playTapped(_ sender: UIButton) {
        if player?.rate == 0 {
            player!.play()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player!.pause()
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
}

