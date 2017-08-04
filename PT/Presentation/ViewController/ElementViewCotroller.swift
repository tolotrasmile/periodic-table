//
// Created by Tolotra on 04/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

class ElementViewController: GenericViewController {

    @IBOutlet weak var scrollerHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!

    var currentElement: ElementItem?

    var elements: [ElementItem] = [] {
        didSet {
            self.layout()
        }
    }

    override func viewDidLoad() {
        self.scrollerHeight.constant = self.scrollView.frame.width / 3
        self.elements = ElementItem.items()
    }

    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func layout() {

        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }

        let size = self.scrollerHeight.constant

        for i in 0..<elements.count {
            let frame = CGRect(x: CGFloat(i) * size, y: 0, width: size, height: size)

            let tile = ElementView(frame: frame)
            tile.element = elements[i]

            if i == 0 {
                tile.activate()
            }

            scrollView.addSubview(tile)
        }

        self.scrollView.contentSize = CGSize(width: CGFloat(elements.count) * size, height: size)

    }


}
