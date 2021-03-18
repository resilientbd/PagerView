//
//  ViewController.swift
//  pagerview
//
//  Created by Sk Faisal on 18/3/21.
//

import UIKit

class ViewController: UIViewController {
    let cellScaleHeight:CGFloat = 0.6
    let cellScaleWidth:CGFloat = 0.8
    var cellWidth:CGFloat?
    var cellHeight:CGFloat?
    var insetX:CGFloat?
    var insetY:CGFloat?
    
    @IBOutlet weak var collection_view: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cellWidth = UIScreen.main.bounds.width * cellScaleWidth
        cellHeight = UIScreen.main.bounds.height * cellScaleHeight
        insetX = (UIScreen.main.bounds.width - cellWidth!) / 2.0
        insetY = (UIScreen.main.bounds.height - cellHeight!) / 2.0
        collection_view.dataSource = self
        collection_view.delegate = self
      
        
        // Do any additional setup after loading the view.
    }
    
    
}
extension ViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * cellScaleWidth, height: UIScreen.main.bounds.height * cellScaleHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: insetX!, bottom: 0, right: insetX!)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collection_view.scrollToNearestVisibleCollectionViewCell()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collection_view.scrollToNearestVisibleCollectionViewCell()
        }
    }
    
    
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}


