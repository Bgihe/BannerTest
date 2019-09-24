//
//  ViewController.swift
//  BannerTest
//
//  Created by apple on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    let width = UIScreen.main.bounds.size.width
    var currentIndex : NSInteger = 0
    var leftImageView = UIImageView()
    var rightImageView = UIImageView()
    var currentImageView = UIImageView()
    var imageArray = [String]()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = ["banner1","banner2","banner3","banner4","banner5","banner6","banner7"]
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
        reloadImage()
        setupTimer()
    }
    
    // 上方banner
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: width * 3, height: 200)
        scrollView.contentOffset = CGPoint(x: width, y: 50)
        scrollView.isPagingEnabled = true
        scrollView.frame = CGRect(x: 0, y: 50, width: width, height: 200)
        rightImageView.frame = CGRect(x: width * 2, y: 50, width: width, height: 200)
        currentImageView.frame = CGRect(x: width * 1, y: 50, width: width, height: 200)
        leftImageView.frame = CGRect(x: width * 0, y: 50, width: width, height: 200)
        scrollView.addSubview(rightImageView)
        scrollView.addSubview(currentImageView)
        scrollView.addSubview(leftImageView)
        scrollView.delegate = self
        return scrollView
    }()
    
    // 下方小圓點
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: 200+50-20, width: width, height: 20)
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.init(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor.init(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        pageControl.numberOfPages = imageArray.count
        pageControl.currentPage = 0
        return pageControl
    }()
    
    // 更新圖片
    func reloadImage(){
        var leftIndex = 0
        var rightIndex = 0
        currentIndex = currentIndex % imageArray.count
        scrollView.setContentOffset(CGPoint(x: width, y: 50), animated: false)
        pageControl.currentPage = (currentIndex - 1 + imageArray.count) % imageArray.count //防止越界
        leftIndex = (currentIndex - 1 + imageArray.count) % imageArray.count //防止越界
        rightIndex = (currentIndex + 1) % imageArray.count
        rightImageView.image = UIImage(named: imageArray[rightIndex])
        currentImageView.image = UIImage(named: imageArray[currentIndex])
        leftImageView.image = UIImage(named: imageArray[leftIndex])
        
    }
    // timer
    func setupTimer() {
   
        timer = Timer.scheduledTimer(timeInterval: 2,target:self,selector:#selector(timeChanged),userInfo:nil,repeats:true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        
    }
    
    
    @objc func timeChanged(){
        currentIndex = currentIndex + 1
        //更新加載試圖
        reloadImage()
    }
  
    //開始拖動
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    //停止拖動
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //向右拖動
        if scrollView.contentOffset.x > width {
            currentIndex = (currentIndex + 1) % imageArray.count
            
        }
        //向左拖動
        if scrollView.contentOffset.x < width{
            currentIndex = (currentIndex - 1 + imageArray.count) % imageArray.count
            
        }
        
        //更新小圓點當前位置
        pageControl.currentPage = (currentIndex - 1 + imageArray.count) % imageArray.count
        reloadImage()
        
        setupTimer()
        
    }
}

