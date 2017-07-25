//
//  CommentVC.swift
//  Global_Garner
//
//  Created by indianic on 25/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class CommentVC: UIViewController ,UITextViewDelegate {

    public var passDataWithIndex:( _ arryData : Any)->() = {_ in}

    @IBOutlet var conHeightTxtViewComment: NSLayoutConstraint!
    

    @IBOutlet var txtviewComment: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
            self.passDataWithIndex(self.txtviewComment.text)  // Passing Data Using Blocks to Parent VC

            self.view.removeFromSuperview()
            self.removeFromParentViewController()
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
