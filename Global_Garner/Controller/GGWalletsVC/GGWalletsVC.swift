//
//  GGWalletsVC.swift
//  Global_Garner
//
//  Created by indianic on 06/07/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class GGWalletsVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var clnGGWallet: UICollectionView!
    
    var arryData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        arryData = ["test","Test2","IoS Develveloper","Php","Java","IONIDevelper"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:cellCollGGWallet = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollGGWallet", for: indexPath) as! cellCollGGWallet
        
        cell.lblTitleName.text = arryData[indexPath.row]
        return cell;
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if let font = UIFont(name: "Helvetica", size: 18)
        {
            let fontAttributes = [NSFontAttributeName: font]
            let aText = arryData[indexPath.item]
            let size = (aText as NSString).size(attributes: fontAttributes)
            return CGSize(width: size.width+20, height: 40)
            
        }
        
        return CGSize(width: 60, height: 40)
    }
    
}


class cellCollGGWallet : UICollectionViewCell
{
    
    @IBOutlet var lblTitleName: UILabel!
}
