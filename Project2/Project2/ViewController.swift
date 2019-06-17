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
    
    var flashSpeed = 0.25
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createLevel()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func createLevel(){
        guard levelCounter < levels.count else {return}
        result.alpha = 0
        collectionView.visibleCells.forEach { $0.isHidden = true }
        activeCells.removeAll()
        
        for item in levels[levelCounter]{
            let indexPath = IndexPath(item: item, section: 0)
            activeCells.append(indexPath)
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.isHidden = false
        }
        
        activeCells = (activeCells as NSArray).shuffled() as! [IndexPath]
        flashSequence = Array(activeCells.dropFirst())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.flashLight()
        }
    }
    
    func flashLight () {
        if let indexPath = flashSequence.popLast() {
            guard let cell = collectionView.cellForItem(at: indexPath) else {return}
            guard let imageView = cell.contentView.subviews.first as? UIImageView else {return}
            imageView.image = UIImage(named: "greenLight")
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            UIView.animate(withDuration: flashSpeed, animations: {
                cell.transform = .identity
            }) {_ in
                imageView.image = UIImage(named: "redLight")
                DispatchQueue.main.asyncAfter(deadline: .now() + self.flashSpeed){
                    self.flashLight()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view.isUserInteractionEnabled = true
                self.setNeedsFocusUpdate()
                }
        }
    }
    
    func gameOver(){
        let alert = UIAlertController(title: "Game Over!", message: "You made it to level \(levelCounter)\n Start again?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { _ in
            self.levelCounter = 0
            self.createLevel()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.isUserInteractionEnabled = false
        result.alpha = 1
        if indexPath == activeCells[0] {
            result.image = UIImage(named: "correct")
            levelCounter += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.createLevel()
            }
        } else {
            result.image = UIImage(named: "wrong")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.gameOver()
            }
        }
    }


}

