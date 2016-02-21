//
//  CharlieChaplinGifView.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 21/02/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit

class CharlieChaplinGifView : UIWebView {
    
    init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        let filePath = NSBundle.mainBundle().pathForResource("waiting", ofType: "gif")!
        let gif = NSData(contentsOfFile: filePath)
        loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
        contentMode = UIViewContentMode.Center
        scalesPageToFit = true
    }
    
    
}
