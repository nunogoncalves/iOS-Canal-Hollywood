//
//  ScheduleOfDayFetcher.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import Foundation
import Kanna

class ScheduleOfDayFetcher {

    var url: NSURL!
    
    var schedule: [ScheduledMovie] = []
    
    let date: NSDate
    let dateStr: String
    
    init(date: NSDate) {
        self.date = date
        dateStr = date.stringFromDateInFormat()
        url = NSURL(string: "http://canalhollywood.pt/programacion/\(dateStr)")
    }
    
    func fetch() -> [ScheduledMovie] {
        var scheduleMovies: [ScheduledMovie] = []
        
        let data = NSData(contentsOfURL: url)
        let dataStr = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String

        if let doc = Kanna.HTML(html: dataStr, encoding: NSUTF8StringEncoding) {
            for scheduleContainerHTML in doc.xpath("//div[@id='parrilla_registro']") {
                let movie = createMovieFromHtmlElement(scheduleContainerHTML)
                scheduleMovies.append(movie)
            }
        }
        
        for(index, movie) in enumerate(scheduleMovies) {
            if index == scheduleMovies.count - 1 {
                movie.endTime = movie.startTime?.dateByAddingTimeInterval(2*60)
            } else {
                movie.endTime = scheduleMovies[index + 1].endTime
            }
            movie.endTime = movie.startTime!.dateByAddingTimeInterval(2*60*60)
        }
        
        return scheduleMovies
    }
    
    private func createMovieFromHtmlElement(element: XMLElement) -> ScheduledMovie {
        let name = element.css("a").text!
        let bulkOriginalName = element.css("#casilla-guiatv018_").toHTML
        let originalName = processOriginalName(bulkOriginalName!)
        let imageUrl = element.css("img")[0]["src"]!
        let bulkGenre = element.css("#lengua-roja_").toHTML
        let genre = processGenreType(bulkGenre!)
        var startTimeStr = element.css("#lengua-roja_").text!
        var url = element.css("a")[0]["href"]!
        
        let movie = ScheduledMovie(
            originalName: originalName,
            localName: name,
            imageUrl: imageUrl,
            startTimeStr: startTimeStr,
            genre: genre,
            url: url
        )
        var startDateTime = NSDate.dateFromString("\(dateStr) \(startTimeStr)", format: "yyyy-MM-dd HH:mm")
        movie.startTime = startDateTime
        
        return movie
    }
    
    private func processOriginalName(var element: String) -> String {
        var index = element.rangeOfString("Título Original: ", options: .LiteralSearch, range: nil, locale: nil)
        element = element.substringFromIndex(index!.endIndex)
        return element.stringByReplacingOccurrencesOfString("-->\n</div>", withString: "", options: nil, range: nil)
    }
    
    private func processGenreType(var element: String) -> String {
        element = element.stringByReplacingOccurrencesOfString("<div class=\"textoblanco12n\" id=\"lengua-roja_\">", withString: "", options: nil, range: nil).stringByReplacingOccurrencesOfString("<!-- -", withString: "", options: nil, range: nil).stringByReplacingOccurrencesOfString("-->\n</div>", withString: "", options: nil, range: nil)
        
        let index = advance(element.startIndex, 6)
        return element.substringFromIndex(index)
    }
}

func p<T>(t: T) {
    println(t)
}

extension NSDate {
    func stringFromDateInFormat(format: String = "yyyy'-'MM'-'dd'") -> String {
        let formatter = NSDateFormatter(localeIdentifier: "pt_PT")
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
    static func dateFromString(dateStr: String, format: String) -> NSDate? {
        let formatter = NSDateFormatter(localeIdentifier: "pt_PT")
        formatter.dateFormat = format
        return formatter.dateFromString(dateStr)
    }
}

extension NSDateFormatter {
    
    convenience init(localeIdentifier: String) {
        self.init()
        locale = NSLocale(localeIdentifier: localeIdentifier)
    }
    
}
