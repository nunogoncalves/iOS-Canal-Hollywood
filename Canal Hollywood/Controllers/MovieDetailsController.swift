//
//  MovieDetailsController.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 09/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class MovieDetailsController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var localNameLabel: UILabel!
    @IBOutlet weak var movieSummary: UILabel!
    @IBAction func imdbClicked() {
        
        let application = UIApplication.sharedApplication()
        if let url = NSURL(string: "imdb:///find?q=godfather") where application.canOpenURL(url){
            application.openURL(url)
        } else {
            application.openURL(NSURL(string: "http://www.imdb.com")!)
        }
    }
    
    var movie: ScheduledMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        if let movie = movie {
            let url = movie.imageUrl.stringByReplacingOccurrencesOfString("/th/", withString: "/")
            ImageLoader.loadImageIn(imageView, url: url)
            originalNameLabel.text = movie.originalName
            localNameLabel.text = movie.localName
            let _ = FetchMovieDetails(movie: movie)
            movieSummary.text = movie.summary
        }
    }
}
