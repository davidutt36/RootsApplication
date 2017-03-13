//
//  ViewController.swift
//  02
//
//  Created by David Utt on 3/13/17.
//  Copyright © 2017 David Utt. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    
    weak var timer: Timer?
    var startTimer: Double = 0
    var time: Double = 0
    var count = ""
    
    //needs to save as interval to control blur delay
//    var countValue =
    
    var timerArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func cameraButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            
            
            //facets
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            
            imagePicker.showsCameraControls = true;
            
            
            //custom view stuff
            let customViewController = CustomOverlayViewController(
                nibName:"CustomOverlayViewController",
                bundle: nil
            )
            let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
            customView.frame = imagePicker.view.frame
            
            //present overlay camera
            //buttons from image picker do not work with custom overlay view, require custom actions
//            self.present(imagePicker, animated: true, completion: {imagePicker.cameraOverlayView = customView})

            //present simple orginal camera
//            self.present(imagePicker, animated: true, completion: nil)
            
            //present camera will full view screen
            self.present(imagePicker, animated: true, completion: {
                let screenSize = UIScreen.main.bounds.size
                let ratio: CGFloat = 4.0 / 3.0
                let cameraHeight: CGFloat = screenSize.width * ratio
                let scale: CGFloat = screenSize.height / cameraHeight
                
                imagePicker.cameraViewTransform = CGAffineTransform(translationX: 0, y: (screenSize.height - cameraHeight) / 2.0)
                imagePicker.cameraViewTransform = imagePicker.cameraViewTransform.scaledBy(x: scale, y: scale)
            })
            
            //start Timer
            StartTime()
        }
    }
    
    @IBAction func photolibraryAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let imageData = UIImageJPEGRepresentation(pickedImage.image!, 0.8)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        
        saveNotice()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo:[NSObject : AnyObject]!) {
        pickedImage.image = image
        self.dismiss(animated: true, completion: nil)
        
        //End Timer
        EndTime()
    }
    
    func saveNotice(){
        let alertController = UIAlertController(title: "Image Saved!", message: "Image saved to the main photo libaray", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func StartTime(){
        startTimer = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.05,
                                     target: self,
                                     selector: #selector(advanceTimer(timer:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func advanceTimer(timer:Timer){
        //Total time since timer started, in seconds
        time = Date().timeIntervalSinceReferenceDate - startTimer
        
        //Convert the time to a string with 2 decimal places
        count = String(format: "%.2f", time)
        //countValue = Int(time)
        
        //Display the time string to a label in our view controller
        print(count)
    }
    
    func EndTime() {
        timer?.invalidate()
        print("You Spent ", count, " seconds taking that picture")
        timerArray.append(count)
        print(timerArray)
    }
    
    
    
    
}
