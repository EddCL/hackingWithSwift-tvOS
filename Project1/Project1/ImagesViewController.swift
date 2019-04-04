//
//  ImagesViewController.swift
//  Project1
//
//  Created by Eduardo Carrillo on 3/28/19.
//  Copyright © 2019 Eduardo Carrillo. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    var category = ""
    var imageViews = [UIImageView]()
    var images = [JSON]()
    var imageCounter = 0
    var appID = "54f120f6298ae8773e64179b1f8732845894d43b58fc58a7b76ade345ce51725"
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var creditLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViews = view.subviews.compactMap{ $0 as? UIImageView} //imageViews is the property we created, it will store the image views in the app.  In an array, makes it easier to swap betwenn images.       All view controllers have a VIEW property (user interface), and all views have a SUBVIEWS property (an array that contains all the user interface components it contains)   compactMap method let us create a new array, it transforms all the items of an existing array (those which can not transform are excluded
        
        imageViews.forEach{$0.alpha = 0}
        
        creditLabel.layer.cornerRadius = 15
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos?client_id=\(appID)&query=\(category)&per_page=100") else {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetch(url)
        }
    }
    
    func fetch(_ url: URL){
        if let data = try? Data(contentsOf: url){
            let json = JSON(data)
            images = json["results"].arrayValue
            downloadImage()
        }
    }
    
    func downloadImage(){
        //figure out what image to display
        let currentImage = images[imageCounter % images.count]
        
        //find its image URL and user credit
        let imageName = currentImage["url"]["full"].stringValue
        let imageCredit = currentImage["user"]["name"].stringValue
        
        //add 1 to imageCounter so next time we load the following image
        imageCounter += 1
        
        //convert it to a Swift URL and download it
        guard let imageURL = URL(string: imageName) else {return}
        guard let imageData = try? Data(contentsOf: imageURL) else {return}
        
        
        //convert the Data to a UIImage
        guard let image = UIImage(data: imageData) else {return}
        
        //push our work to the main thread
        DispatchQueue.main.async {
            //display it in the first image view, and update the image credit label
            self.show(image, credit: imageCredit)
        }
    }
    
    func show(_ image: UIImage, credit: String){
        //stop the activity indicator animation
        spinner.stopAnimating()
        
        //figure out which view to activate and deactivate
        let imageViewToUse = imageViews[imageCounter % imageViews.count]
        let otherImageView = imageViews[(imageCounter + 1) % imageViews.count]
        
        //start an animation over 2 seconds
        UIView.animate(withDuration: 2.0, animations: {
            //make the image view use our image, and alpha it up to 1
            imageViewToUse.image = image
            imageViewToUse.alpha = 1
            
            //fade out the credit label to avoid it looking wrong
            self.creditLabel.alpha = 0
            
            //move the deactivated image view to the back, behind the activated one
            self.view.sendSubviewToBack(otherImageView)
        }) { _ in
            self.creditLabel.text = " \(credit.uppercased())"
            self.creditLabel.alpha = 1
            
            otherImageView.alpha = 0
            otherImageView.transform = .identity
            
            UIView.animate(withDuration: 10.0, animations: { imageViewToUse.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { _ in
                DispatchQueue.global(qos: .userInteractive).async {
                    self.downloadImage()
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
