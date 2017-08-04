//
// Created by Tolotra on 04/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {

    func showPopup(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(controller, animated: animated, completion: completion)
    }

    // Remove first scrollview top inset
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}