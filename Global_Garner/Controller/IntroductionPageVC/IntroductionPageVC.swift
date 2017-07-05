//
//  IntroductionPageVC.swift
//  Global_Garner
//
//  Created by indianic on 05/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class IntroductionPageVC: UIViewController ,UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!    
    @IBOutlet var lblHeaderText: UILabel!
    @IBOutlet var lblMessageText: UILabel!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUPI()
    {
        
        
        btnLogin.layer.cornerRadius = 3.0
        btnLogin.layer.borderWidth = 1.0
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.borderColor = UIColor(red: CGFloat((68.0 / 255.0)), green: CGFloat((134.0 / 255.0)), blue: CGFloat((251.0 / 255.0)), alpha: CGFloat(1)).cgColor
        btnSignUp.layer.cornerRadius = 3.0
        btnSignUp.layer.borderWidth = 0.0
        btnSignUp.layer.masksToBounds = true
        
        
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2

        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "cashback")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "FPV")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "Relations")
        
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        
        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSignUPClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(storyboard: .Login)
        let loginVC: LoginVC = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)

        
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {

        let storyboard = UIStoryboard(storyboard: .Login)
        let loginVC: LoginVC = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)

    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        
//        let pageWidth: CGFloat = scrlMainContainer.frame.size.width
//        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
//        
//        pageControl.currentPage = Int(currentPage)
//        if currentPage == 0 {
//            lblHeaderText.text = "Pay & Get 100% Cashback"
//            lblMessageText.text = "So, get ready to earn & enjoy cash back on everything you shop via Global Garner."
////            imgNext.image = UIImage(named: "cashback")
//        }
//        else if currentPage == 1 {
//            lblHeaderText.text = "Fuel Cashback"
//            lblMessageText.text = "1 Litre of GG/GG Co-Branded dringking water bottle will give you 1005 cashback of 1 litre fuel for your registered vehicle."
////            imgNext.image = UIImage(named: "FPV")
//        }
//        else {
//            lblHeaderText.text = "Socialize & Earn"
//            lblMessageText.text = "Global Garner is world's 1st and only social media platform where all users can earn too."
////            imgNext.image = UIImage(named: "Relations")
//        }
//    }

    //MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly

        if Int(currentPage) == 0{
            lblHeaderText.text = "Pay & Get 100% Cashback"
            lblMessageText.text = "So, get ready to earn & enjoy cash back on everything you shop via Global Garner."
        }
        else if Int(currentPage) == 1{
            lblHeaderText.text = "Fuel Cashback"
            lblMessageText.text = "1 Litre of GG/GG Co-Branded dringking water bottle will give you 1005 cashback of 1 litre fuel for your registered vehicle."


    }else if Int(currentPage) == 2{
        lblHeaderText.text = "Socialize & Earn"
        lblMessageText.text = "Global Garner is world's 1st and only social media platform where all users can earn too."

        }
    }
}

