//
//  ImageLoader.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 13/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class ImageLoader {
    static func loadImageIn(imageView: UIImageView, url: String) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = UIImage(data: data!)
            }
        }
    }
}
