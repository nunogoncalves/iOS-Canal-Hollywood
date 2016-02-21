//
//  CharlieChaplinGifView.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 21/02/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit

class CharlieChaplinGifView : UIWebView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        let filePath = NSBundle.mainBundle().pathForResource("waiting", ofType: "gif")!
        let gifData = NSData(contentsOfFile: filePath)
        loadData(gifData!, MIMEType: "image/gif", textEncodingName: "", baseURL: NSURL())
//        loadData(gif!, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
        contentMode = UIViewContentMode.Center
        scalesPageToFit = true
    }
    
    
}
