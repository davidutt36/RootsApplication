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
    
    var delegate: CustomOverlayDelegate! = nil
    @IBOutlet weak var cameraLabel: UILabel!
    

    @IBAction func shootButton(_ sender: Any) {
        cameraLabel.text = "Even Cooler Camera"
        delegate.didShoot(overlayView: self)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cameraLabel.text = "I want to exit"
        delegate.didCancel(overlayView: self)
    }
}
