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
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        arryData = ["test","Test2","IoS Develveloper","Php","Java","IONIDevelper" , "Patrick Panchal ios Developer","QA Testing","Alpha","Swift"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button Click Action
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:cellCollGGWallet = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollGGWallet", for: indexPath) as! cellCollGGWallet
        
        cell.lblTitleName.text = arryData[indexPath.row]
        cell.viewBG.layer.cornerRadius = 20
        
        cell.viewBG.clipsToBounds = true
        cell.lblTitleName.textAlignment = .left
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self,action:#selector(btnDeleteClicked(sender:)), for: .touchUpInside)
        
        return cell;
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if let font = UIFont(name: "Open Sans", size: 18)
        {
            let fontAttributes = [NSFontAttributeName: font]
            let aText = arryData[indexPath.item]
            let size = (aText as NSString).size(attributes: fontAttributes)
            return CGSize(width: size.width+20+(30), height: 40)
            
        }
        
        return CGSize(width: 60, height: 40)
    }
    
    
    //MARK: - Collection View Animation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let collectionViewCell = collectionView.cellForItem(at: indexPath)! as UICollectionViewCell
        
        UIView.animate(withDuration: 0.06, animations: {
            collectionViewCell.layer.transform = CATransform3DMakeScale(0.70,0.70,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                collectionViewCell.layer.transform = CATransform3DMakeScale(1,1,1)
                //move profile
            })
        })
        
        
    }
    
    //MARK: Collection view Delete Clicked
    func btnDeleteClicked(sender: UIButton) {
        
        
        let indexPath = sender.tag
        print("indexPath\(indexPath)")
        
        
        arryData.remove(at: indexPath)
        clnGGWallet.reloadData()
    }
    
    
}

//MARK: - Collection Cell GGWallet
class cellCollGGWallet : UICollectionViewCell
{
    @IBOutlet var lblTitleName: UILabel!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var viewBG: UIView!
}
