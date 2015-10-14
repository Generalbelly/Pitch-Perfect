//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by ShimmenNobuyoshi on 2015/03/08.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {

    var filePathUrl: NSURL!
    var title: String!

    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }

}