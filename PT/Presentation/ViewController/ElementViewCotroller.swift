//
// Created by Tolotra on 04/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

class ElementViewController: GenericViewController {

    @IBOutlet weak var scrollerHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var elementDetailView: UIView!

    var currentElement: ElementItem?

    var elements: [ElementItem] = [] {
        didSet {
            self.layout()
        }
    }

    override func viewDidLoad() {
        self.scrollerHeight.constant = self.scrollView.frame.width / 3

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.elements = ElementItem.items()
        })

        let detail = ElementDetailView(frame: CGRect(x: 0, y: 0, width: self.elementDetailView.frame.width, height: self.elementDetailView.frame.height))
        self.elementDetailView.addSubview(detail)

        self.scrollView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0)
    }

    override func viewWillAppear(animated: Bool) {

        UIView.animateWithDuration(0.4) {
            self.contentView.transform = CGAffineTransformIdentity
        }

        UIView.animateWithDuration(0.4, delay: 0.4, options: [],
            animations: {
                self.scrollView.transform = CGAffineTransformIdentity
            },
            completion: nil
        )
    }

    @IBAction func dismiss(sender: AnyObject) {
        self.view.layoutIfNeeded() // call it also here to finish pending layout operations

        UIView.animateWithDuration(0.4) {
            self.scrollView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        }

        UIView.animateWithDuration(0.4, delay: 0.4, options: [.BeginFromCurrentState, .AllowUserInteraction],
            animations: {
                self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0)
            },
            completion: { completion in
                if completion {
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
            }
        )
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
                tile.highlight()
            }

            scrollView.addSubview(tile)
        }

        self.scrollView.contentSize = CGSize(width: CGFloat(elements.count) * size, height: size)

    }


}
