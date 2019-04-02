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
        } //p148
    }
    
    func fetch(_ url: URL){
        
    }
    
    func downloadImage(){
        
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
