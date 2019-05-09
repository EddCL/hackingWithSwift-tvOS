//
//  ViewController.swift
//  Project2
//
//  Created by Eduardo Carrillo on 5/8/19.
//  Copyright © 2019 Eduardo Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var result: UIImageView!
    
    var activeCells = [IndexPath]()
    var flashSequence = [IndexPath]()
    var levelCounter = 0
    
    let levels = [[6,7,8],
                  [1,3,11,13],
                  [5,6,7,8,9],
                  [0,4,5,9,10,14],
                  [1,2,3,7,11,12,13],
                  [0,2,4,5,9,10,12,14],
                  [1, 2, 3, 6, 7, 8, 11, 12, 13],
                  [0, 1, 2, 3, 4, 10, 11, 12, 13, 14],
                  [1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13],
                  [0, 1, 3, 4, 5, 6, 8, 9, 10, 11, 13, 14],
                  [0, 1, 2, 3, 4, 6, 7, 8, 10, 11, 12, 13, 14],
                  [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14],
                  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func createLevel(){
        //pagina172
    }
    


}

