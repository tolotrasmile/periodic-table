//
//  ViewController.swift
//  PT
//
//  Created by Tolotra on 02/08/2017.
//  Copyright © 2017 Etech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var elements: [ElementItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5.0

        let size = (view.frame.height / 7) - 1
        layout.itemSize = CGSize(width: size, height: size)

        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsetsMake(0, spacing + 20, spacing, spacing)

        elements = ElementItem.items()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("x : \(scrollView.contentOffset.x)");
        print("y : \(scrollView.contentOffset.y)");
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell: ElementItemCell = collectionView.dequeueReusableCellWithReuseIdentifier("ElementItemCell", forIndexPath: indexPath) as! ElementItemCell

        let element = elements[indexPath.row]

        cell.name.text = "\(element.name!)"
        cell.symbol.text = "\(element.symbol!)"
        cell.weight.text = "\(element.number!)"

        return cell;
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
}
