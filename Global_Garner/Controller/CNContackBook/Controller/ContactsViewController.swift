//
//  ContactsViewController.swift
//  Global_Garner
//
//  Created by indianic on 16/08/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    
    // Outlet
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()
    
    @IBOutlet var tblViewContacts: UITableView!
    
    
    //View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        requestAccessToContacts { (success) in
            
            if success{
                self.retriveContacts({ (success, contacts) in
                    
                    print("Contacts Data is ",contacts)
                    if success && (contacts?.count)! > 0
                    {
                        self.contacts = contacts!
                        self.tblViewContacts.reloadData()
                    }
                })
            }
        }
    }
    
    
    // MARK:- Contacts Details
    // Request to Access Contacts
    func requestAccessToContacts(_ Complition: @escaping (_ success: Bool) -> Void )
    {
        let authorisationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorisationStatus {
        case .authorized:Complition(true)
            break
        case .denied,.notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (accessGranted, error) in
                Complition(true)
            })
        default:
            Complition(false)
        }
    }

    
    //Fetch All The Contacts
    func retriveContacts(_ complition : (_ success:Bool , _ contacts:[ContactEntry]?) -> Void)
    {
        var contacts = [ContactEntry]()
    
        do {
            let contactFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor ,  CNContactFamilyNameKey as CNKeyDescriptor , CNContactImageDataKey as CNKeyDescriptor , CNContactImageDataAvailableKey as CNKeyDescriptor , CNContactPhoneNumbersKey as CNKeyDescriptor , CNContactEmailAddressesKey as CNKeyDescriptor])
            
            try contactStore.enumerateContacts(with: contactFetchRequest, usingBlock: { (cnContact, error) in
                //
                if let contact = ContactEntry(cnContact: cnContact) { contacts.append(contact) }
            })
            complition(true,contacts)
        } catch  {
            complition(false,contacts)
        }
    }
    
    
    

    //MARK:- UITableViewDataSource && Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        let entry = contacts[(indexPath as NSIndexPath).row]
        
        cell.configureWithContactEntry(entry)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let entry = contacts[(indexPath as NSIndexPath).row]
    
        print("Selected Contact name",entry.name)
        print("Selected Contact name",entry.email)
        print("Selected Contact name",entry.phone)
        
    }
    


    // MARK: - Button Action Event
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MArk : TablewView Cell

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    
    func setCircularAvatar() {
        contactImageView.layer.cornerRadius = contactImageView.bounds.size.width / 2.0
        contactImageView.layer.masksToBounds = true
    }
    
    func configureWithContactEntry(_ contact: ContactEntry) {
        contactNameLabel.text = contact.name
        contactEmailLabel.text = contact.email ?? ""
        contactPhoneLabel.text = contact.phone ?? ""
        contactImageView.image = contact.image ?? UIImage(named: "defaultUser")
        setCircularAvatar()
    }
}
