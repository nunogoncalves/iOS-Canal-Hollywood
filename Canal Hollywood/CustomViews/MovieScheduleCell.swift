//
//  MovieScheduleCell.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class MovieScheduleCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var onAirImage: UIImageView!
    @IBOutlet weak var movieLocalNameLabel: UILabel!
    @IBOutlet weak var movieOriginalNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var scheduledMovie: ScheduledMovie? {
        didSet {
            movieLocalNameLabel.text = scheduledMovie!.localName
            movieOriginalNameLabel.text = scheduledMovie!.originalName
            startTimeLabel.text = scheduledMovie!.startTimeStr
            genreLabel.text = scheduledMovie!.genre
            onAirImage.hidden = !scheduledMovie!.isNow()
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) { // 1
                let data = NSData(contentsOfURL: NSURL(string: self.scheduledMovie!.imageUrl)!)
                dispatch_async(dispatch_get_main_queue()) { // 2
                    self.movieImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    @IBOutlet weak var scheduleTimeTextField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
}
