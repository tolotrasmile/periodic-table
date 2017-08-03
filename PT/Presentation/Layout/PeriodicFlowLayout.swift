//
// Created by Tolotra on 03/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

class PeriodicFlowLayout: UICollectionViewLayout {

    func contentSize() -> CGSize {
        return CGSizeMake(20, 20)
    }

    func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(0, 0, 0, 0)
    }

}
