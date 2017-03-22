//
//  CustomOverlayView.swift
//  01
//
//  Created by David Utt on 3/13/17.
//  Copyright © 2017 David Utt. All rights reserved.
//

import UIKit

protocol CustomOverlayDelegate{
    func didCancel(overlayView:CustomOverlayView)
    func didShoot(overlayView:CustomOverlayView)
}

class CustomOverlayView: UIView {
    
    @IBOutlet weak var cameraLabel: UILabel!
    var delegate:CustomOverlayDelegate! = nil
    
    @IBAction func shootButton(_ sender: UIButton) {
        cameraLabel.text = "take a pic"
        delegate.didShoot(overlayView: self)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cameraLabel.text = "Leave it"
        delegate.didCancel(overlayView: self)
    }
}



