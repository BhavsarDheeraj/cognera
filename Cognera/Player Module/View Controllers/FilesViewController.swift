//
//  FilesViewController.swift
//  Cognera
//
//  Created by DHEERAJ BHAVSAR on 08/06/19.
//  Copyright © 2019 Dheeraj Bhavsar. All rights reserved.
//

import UIKit

class FilesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBActions
    @IBAction func didTapImageButton(_ sender: UIButton) {
        let playerController = StoryBoards.playerStoryboard.instantiateViewController(withIdentifier: PlayerViewController.identifier) as! PlayerViewController
        playerController.itemUrl = URLs.imageFileURL
        navigationController?.pushViewController(playerController, animated: true)
    }
    
    @IBAction func didTapAudioButton(_ sender: UIButton) {
        let playerController = StoryBoards.playerStoryboard.instantiateViewController(withIdentifier: PlayerViewController.identifier) as! PlayerViewController
        playerController.itemUrl = URLs.audioFileURL
        navigationController?.pushViewController(playerController, animated: true)
    }
}
