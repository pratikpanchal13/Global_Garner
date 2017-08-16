//
//  MakeMyCartVC.swift
//  Global_Garner
//
//  Created by indianic on 24/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import ImageSlideshow

class MakeMyCartVC: UIViewController {

    @IBOutlet var slideshow: ImageSlideshow!

    
    let localSource = [ImageSource(imageString: "P1")!, ImageSource(imageString: "P2")!, ImageSource(imageString: "P3")!, ImageSource(imageString: "P4")!]
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fireBaseError() // FIrebase Crash Analytics
        
        
        // Do any additional setup after loading the view.
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 2.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.blue
        slideshow.pageControl.pageIndicatorTintColor = UIColor.red
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
            self.pageIndex = page
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)

        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(recognizer)


        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
//        slideshow.addGestureRecognizer(recognizer)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func fireBaseError()
//    {
//                assert(false)
// 
//    }
    
    func didTap() {
        
        switch pageIndex {
        case 0:
            print("Index is ",0)
            break;
        case 1:
            print("Index is ",1)
            break;
        case 2:
            print("Index is ",2)
            break;
        case 3:
            print("Index is ",3)
            break;
        default:
            break;
        }
        
//        let fullScreenController = slideshow.presentFullScreenController(from: self)
//        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }


}
