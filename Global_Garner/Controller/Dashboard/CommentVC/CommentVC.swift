//
//  CommentVC.swift
//  Global_Garner
//
//  Created by indianic on 25/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Cosmos

class CommentVC: UIViewController ,UITextViewDelegate {

    public var passDataWithIndex:( _ dctCommentData : Any)->() = {_ in}

    @IBOutlet var conHeightTxtViewComment: NSLayoutConstraint!
    @IBOutlet var txtviewComment: UITextView!
    
    
    // For Ratting
    @IBOutlet var viewCosmos: CosmosView!
    var startRating:Float = 0.0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRaetting()  // Fot Setting Ratting
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
     
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: +self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
        }) { (isFinished) in
            //
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
    }
    
    
    @IBAction func btnDoneClicked(_ sender: Any) {
    
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: +self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
        }) { (isFinished) in
            //
            
            
            var dct  = [String:Any]()
            dct["Ratting"]  = self.startRating
            dct["Comment"] = self.txtviewComment.text
            
            
            self.passDataWithIndex(dct)  // Passing Data Using Blocks to Parent VC

            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
        

    }
    
    func setRaetting()
    {
        
        
        
        // Do not change rating when touched
        // Use if you need just to show the stars without getting user's input
        viewCosmos.settings.updateOnTouch = true
        
        
        // Show only fully filled stars
        viewCosmos.settings.fillMode = .half
        // Other fill modes: .half, .precise
        
        
        // Set image for the filled star
//        viewCosmos.settings.filledImage  = #imageLiteral(resourceName: "ic_btnStartFill")
        
        // Set image for the empty star
//        viewCosmos.settings.emptyImage = #imageLiteral(resourceName: "ic_btnStart")
        
        
        // Register touch handlers
        viewCosmos.didFinishTouchingCosmos = { rating in
        
            self.startRating = Float(rating)
            print("Rating is",rating)
        
        }
        
        viewCosmos.didTouchCosmos  = {rating in

            self.startRating = Float(rating)

            print("Rating is -- ",rating)
        }
        
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: :- TexxtView delegate method
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth: CGFloat = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame: CGRect = textView.frame
        newFrame.size = CGSize(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
        print("this is updating height \(NSStringFromCGSize(newFrame.size))")
        
//        if newFrame.size.height <= 100 {
//            UIView.animate(withDuration: 0.2, animations: {() -> Void in
//                self.conHeightTxtViewComment.constant = newFrame.size.height
//            })
//        }
        
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            self.conHeightTxtViewComment.constant = newFrame.size.height
        })

    }

}




