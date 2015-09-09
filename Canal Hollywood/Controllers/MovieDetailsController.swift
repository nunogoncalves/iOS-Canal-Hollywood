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
    
    var movie: ScheduledMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) { // 1
                let data = NSData(contentsOfURL: NSURL(string: movie.imageUrl.stringByReplacingOccurrencesOfString("/th/", withString: "/", options: nil, range: nil))!)
                dispatch_async(dispatch_get_main_queue()) { // 2
                    self.imageView.image = UIImage(data: data!)
                }
            }
            
            originalNameLabel.text = movie.originalName
            localNameLabel.text = movie.localName
        }
    }
}
