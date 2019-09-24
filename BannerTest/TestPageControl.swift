//
//  TestPageControl.swift
//  BannerTest
//
//  Created by apple on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TestPageControl: UIPageControl {
    var scroll = UIScrollView()
    let width = UIScreen.main.bounds.size.width
    var height = UIScreen.main.bounds.size.height - 50
    var currentIndex : NSInteger = 0
    var left = UIImageView()//上一个imageView
    var right = UIImageView()// 下一个imageView
    var current = UIImageView() // 当前imageView
    var imageArray = [String]()
    var timer = Timer()
    
    
}
