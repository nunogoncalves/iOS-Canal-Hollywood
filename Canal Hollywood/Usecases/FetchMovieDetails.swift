//
//  FetchMovieDetails.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 13/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import Kanna

class FetchMovieDetails {
    
    var url: NSURL!
    var movie: ScheduledMovie!
    
    init(movie: ScheduledMovie) {
        self.movie = movie
        url = NSURL(string: "http://canalhollywood.pt\(movie.url!)/")!
     
        let data = NSData(contentsOfURL: url)
        let dataStr = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
       
        if let doc = Kanna.HTML(html: dataStr, encoding: NSUTF8StringEncoding) {
            let text = doc.xpath("//div[@id='texto_principal_']").text!
            movie.summary = text
        }
    }
}
