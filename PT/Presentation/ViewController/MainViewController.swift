//
// Created by Tolotra on 03/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import UIKit

class MainViewController: GenericViewController {

    @IBOutlet weak var rowsView: UIScrollView!
    @IBOutlet weak var columnsView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!

    var elements: [ElementItem] = [] {
        didSet {
            self.layout()
        }
    }

    let maxRow: Int = 10
    let maxColumn: Int = 18
    let inset: CGFloat = 0.0
    var size: CGFloat = 100.0
    var part: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        self.size = elementSize()

        self.layoutIndicators()
        self.elements = ElementItem.items()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func layout() {

        self.size = elementSize()

        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }

        for item in self.elements {
            let frame = self.frameForItem(item)
            let tile = ElementView(frame: CGRectInset(frame, inset, inset))
            tile.delegate = self
            tile.element = item
            scrollView.addSubview(tile)
        }

        self.scrollView.contentSize = CGSize(width: CGFloat(size) * ElementItem.maxPoint().x, height: (CGFloat(size) * ElementItem.maxPoint().y))
        self.scrollView.directionalLockEnabled = true

    }

    func layoutIndicators() {

        // rows
        for i in 0..<maxRow {

            if i + 1 == 8 {
                continue
            }

            let text = i + 1 > 7 ? String(i) : String(i + 1)
            let frame = CGRect(x: 0, y: CGFloat(i) * size, width: rowsView.frame.width, height: size)

            let row = MarkView(frame: CGRectInset(frame, inset, inset))
            row.label.text = text
            rowsView.addSubview(row)
        }

        rowsView.contentSize = CGSize(width: rowsView.frame.width, height: size * CGFloat(maxRow))

        // Columns
        for i in 0..<maxColumn {
            let frame = CGRect(x: CGFloat(i) * size, y: 0, width: size, height: columnsView.frame.height)
            let col = MarkView(frame: CGRectInset(frame, inset, inset))
            col.label.text = String(i + 1)
            columnsView.addSubview(col)
        }

        columnsView.contentSize = CGSize(width: size * CGFloat(maxColumn), height: columnsView.frame.height)
    }

    func frameForItem(item: ElementItem) -> CGRect {
        return CGRect(x: CGFloat(item.x! - 1) * size, y: (CGFloat(item.y! - 1) * size), width: size, height: size)
    }

    func elementSize() -> CGFloat {
        return self.scrollView.frame.width / 8
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}

extension MainViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.1) {

            if (scrollView == self.scrollView) {
                self.rowsView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
                self.columnsView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
                return
            }

            if (scrollView == self.rowsView) {
                self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.rowsView.contentOffset.y)
                return
            }

            if (scrollView == self.columnsView) {
                self.scrollView.contentOffset = CGPoint(x: self.columnsView.contentOffset.x, y: self.scrollView.contentOffset.y)
                return
            }
        }

    }

}

extension MainViewController: ElementViewDelegate {

    func clickElement(element: ElementItem?) {
        //let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ElementViewController") as! ElementViewController
        self.performSegueWithIdentifier("showDetails", sender: self)
    }

}