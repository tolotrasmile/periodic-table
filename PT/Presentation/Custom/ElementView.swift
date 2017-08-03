//
//  ElementView.swift
//  PT
//
//  Created by Tolotra on 03/08/2017.
//  Copyright © 2017 Etech. All rights reserved.
//

import UIKit

@IBDesignable class ElementView: UIView {

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


    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ElementView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
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
        }
    }

    @IBAction func touchDown(sender: AnyObject) {
        self.highlight()
    }

    @IBAction func touchCancel(sender: AnyObject) {
        print("touchCancel")
    }

    @IBAction func touchUpOutside(sender: AnyObject) {
        print("touchUpOutside")
    }
}
