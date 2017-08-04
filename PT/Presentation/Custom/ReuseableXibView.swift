//
//  ReuseableXibView.swift
//  PT
//
//  Created by Tolotra on 04/08/2017.
//  Copyright © 2017 Etech. All rights reserved.
//

import Foundation

import UIKit

public extension NSObject {

    public class var nameOfClass: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }

    public var nameOfClass: String {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
    }

}

@IBDesignable public class ReuseableXibView: UIView {

    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        view = self.loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.nameOfClass, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}