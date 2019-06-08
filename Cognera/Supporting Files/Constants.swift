//
//  Constants.swift
//  Cognera
//
//  Created by DHEERAJ BHAVSAR on 08/06/19.
//  Copyright © 2019 Dheeraj Bhavsar. All rights reserved.
//

import UIKit

struct URLs {
    static let audioFileURL = URL(string: "https://dheerajbhavsar.ml/wp-content/uploads/2019/06/mix.mp3")
    static let imageFileURL = URL(string: "https://www.dheerajbhavsar.me/assets/images/profile.jpeg")
}

struct StoryBoards {
    static let playerStoryboard = UIStoryboard(name: "Player", bundle: nil)
}

struct ErrorMessages {
    static let fileError = "Cannot play this file."
}
