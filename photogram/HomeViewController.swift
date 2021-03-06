//
//  ViewController.swift
//  photogram
//
//  Created by Alexander Leishman on 11/28/15.
//  Copyright © 2015 Alexander Leishman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var postcardLabel: UILabel!
    @IBOutlet weak var postcardListContainer: UIView!
    private let reuseIdentifier = "PostcardCell"
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0) // TODO, update
    @IBOutlet weak var postcardCollectionView: UICollectionView!
    
    var postcards = [Postcard]()
    
    func fetchPostcards() {
        func cb(pcards: [Postcard]) -> Void {
            postcards = pcards
//            dispatch_async(dispatch_get_main_queue(), {
            self.postcardCollectionView.reloadData()
            self.postcardLabel.text = "You've created \(postcards.count) Postcards!"
//            });
//            self.postcardCollectionView.reloadData()
        }
        
        postcards = Postcard.all(inManagedContext: AppDelegate.managedObjectContext!, callback: cb)
    }
    
//    override func viewDidLayoutSubviews() {
//        self.postcardCollectionView.collectionViewLayout.invalidateLayout()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postcardCollectionView.dataSource = self
        postcardCollectionView.contentInset = UIEdgeInsets(top: -60, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchPostcards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func photoForIndexPath(indexPath: NSIndexPath) -> UIImage? {
        let pcard = postcards[indexPath.row]
        return pcard.getUIImage()
    }
    
    // MARK: UICollectionViewDelegate methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected item")
        // TODO
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Postcard count: \(postcards.count)")
        return postcards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PostcardViewCell
        let photo = photoForIndexPath(indexPath)
        cell.postcardImage.image = photo
        return cell
    }
    
}

