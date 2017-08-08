//
//  ElementView.swift
//  PT
//
//  Created by Tolotra on 03/08/2017.
//  Copyright © 2017 Etech. All rights reserved.
//

import UIKit

protocol ElementViewDelegate {
    func clickElement(element: ElementItem?)
}

@IBDesignable class ElementView: ReuseableXibView {

    var delegate: ElementViewDelegate?

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelName: UILabel!

    var element: ElementItem? {
        didSet {
            if nil != element {
                self.labelName.text = element!.name
                self.labelNumber.text = String(element!.number!)
                self.labelSymbol.text = element!.symbol
                self.contentView.backgroundColor = element!.color()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
        tap.minimumPressDuration = 0
        self.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // called by gesture recognizer
    func tapHandler(gesture: UITapGestureRecognizer) {

        switch gesture.state {
        case .Began:
            self.highlight()
            self.makeViewShine()
            break
        case .Ended:self.activate()
            break
        default:
            break
        }
    }

    func highlight() {
        UIView.animateWithDuration(0.5) {
            self.labelSymbol.textColor = UIColor.blackColor()
            self.labelName.textColor = UIColor.blackColor()
            self.labelNumber.textColor = UIColor.blackColor()
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
    }

    func activate() {
        UIView.animateWithDuration(0.5) {
            self.labelSymbol.textColor = UIColor.whiteColor()
            self.labelName.textColor = UIColor.whiteColor()
            self.labelNumber.textColor = UIColor.whiteColor()
            self.contentView.backgroundColor = self.element!.color()
            self.layer.shadowRadius = 0.0
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }

    func makeViewShine() {

        self.layer.shadowColor = UIColor.whiteColor().CGColor
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false

        UIView.animateWithDuration(0.7, delay: 0, options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(0.9, 0.9)
            },
            completion: { b in
                self.activate()
                if self.delegate != nil {
                    self.delegate!.clickElement(self.element)
                }
            }
        )
    }
}
