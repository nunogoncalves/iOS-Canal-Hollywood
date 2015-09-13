//
//  ScheduledMovie.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import Foundation

class ScheduledMovie {
    
    var originalName: String
    var localName: String
    var imageUrl: String
    var startTimeStr: String
    var genre: String
    
    var startTime: NSDate?
    var endTime: NSDate?
    
    var url: String?
    
    var summary: String?
    
    init(originalName: String, localName: String, imageUrl: String, startTimeStr: String, genre: String, url: String) {
        self.localName = localName
        self.originalName = originalName
        self.imageUrl = imageUrl
        self.startTimeStr = startTimeStr
        self.genre = genre
        self.url = url
    }
    
    func isNow() -> Bool {
        if let start = startTime, end = endTime {
            let now = NSDate()
            return start.timeIntervalSince1970 < now.timeIntervalSince1970 && end.timeIntervalSince1970 > now.timeIntervalSince1970
        } else {
            return false
        }
    }
}