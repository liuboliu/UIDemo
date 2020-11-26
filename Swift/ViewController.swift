//
//  ViewController.swift
//  Swift
//
//  Created by 刘博 on 2020/11/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        setupController()

        // Do any additional setup after loading the view.
    }

    lazy var collectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.view.bounds.width, height: 200)
            
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), collectionViewLayout: flowLayout)
            
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = UIColor.white
            collectionView.delegate = self
            collectionView.dataSource = self
            self.view.addSubview(collectionView)
            
            return collectionView
        }()
    lazy var pageControl: UIPageControl = {
            let pageControl = UIPageControl(frame: CGRect(x: 0, y: 150, width: self.view.bounds.width, height: 50))
            
            pageControl.numberOfPages = self.imageNameList.count
            pageControl.currentPage = 0
            
            pageControl.tintColor = UIColor.black
            pageControl.pageIndicatorTintColor = UIColor.gray;
            
            return pageControl;
        }()
        
        lazy var imageNameList: [String] = {
            let imageList = ["1", "2", "3", "4"]
            
            return imageList
        }()


        
        func setupController() {
            /// 设置数据
            collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
            
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            
            self.view.addSubview(pageControl)
        }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// 这步只是防止崩溃
        if (imageNameList.count == 0) {
            return 0
        }
        return imageNameList.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        /// 给图片赋值（在首尾分别添加两张图片）
        if (indexPath.row == 0) {
            cell.imageName = imageNameList.last
        } else if (indexPath.row == self.imageNameList.count + 1) {
            cell.imageName = imageNameList.first
        } else {
            cell.imageName = imageNameList[indexPath.row - 1]
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// 当UIScrollView滑动到第一位停止时，将UIScrollView的偏移位置改变
        if (scrollView.contentOffset.x == 0) {
            scrollView.contentOffset = CGPoint(x: CGFloat(self.imageNameList.count) * self.view.bounds.width,y: 0)
            self.pageControl.currentPage = self.imageNameList.count
            /// 当UIScrollView滑动到最后一位停止时，将UIScrollView的偏移位置改变
        } else if (scrollView.contentOffset.x == CGFloat(self.imageNameList.count + 1) * self.view.bounds.width) {
            scrollView.contentOffset = CGPoint(x: self.view.bounds.width,y: 0)
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.currentPage = Int(scrollView.contentOffset.x / self.view.bounds.width) - 1
        }
    }
}


