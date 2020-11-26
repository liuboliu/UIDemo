//
//  ImageCollectionViewCell.swift
//  SwiftTest
//
//  Created by 刘博 on 2020/11/26.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    /// 显示的图片
    let imageView = UIImageView()
    var imageName: String? = "" {
        didSet {
            if let name = imageName {
                imageView.image = UIImage(named: name)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell();
    }
    
    /// 初始化视图
    func setupCell() {
        imageView.frame = self.bounds
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
