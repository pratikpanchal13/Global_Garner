//
//  ContactsViewController.swift
//  Global_Garner
//
//  Created by indianic on 16/08/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate, CNContactPickerDelegate {

    
    // Outlet
    var contactStore = CNContactStore()
    var contacts = [ContactEntry]()
    var arySearchList = [ContactEntry]()
    @IBOutlet var tblViewContacts: UITableView!
    
    
    //FOR Search
    var isSearch:Bool = false
    
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var txtSearch: UITextField!
    
    
    //View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Searching Data
        txtSearch.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        requestAccessToContacts { (success) in
            
            if success{
                self.retriveContacts({ (success, contacts) in
                    
                    print("Contacts Data is ",contacts)
                    if success && (contacts?.count)! > 0
                    {
                        self.contacts = contacts!
                    
                        self.arySearchList = contacts!
                        
                        self.tblViewContacts.reloadData()
                    }
                })
            }
        }
    }
    
    //MARK:- UITableViewDataSource && Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
        
        if isSearch{
            return arySearchList.count
        }
        else{
            return contacts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        
        if isSearch{
            let entry = arySearchList[(indexPath as NSIndexPath).row]
            cell.configureWithContactEntry(entry)


        }
        else{
            let entry = contacts[(indexPath as NSIndexPath).row]
            cell.configureWithContactEntry(entry)

        }
        
//        let entry = contacts[(indexPath as NSIndexPath).row]
        
//        cell.configureWithContactEntry(entry)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    
        if isSearch{
            let entry = arySearchList[(indexPath as NSIndexPath).row]
            print("Selected Contact name",entry.name)
            print("Selected Contact name",entry.email)
            print("Selected Contact name",entry.phone)
        }
        else
        {
            let entry = self.contacts[(indexPath as NSIndexPath).row]
            print("Selected Contact name",entry.name)
            print("Selected Contact name",entry.email)
            print("Selected Contact name",entry.phone)
        }
      
        
    }
    


    // MARK: - Button Action Event
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectContactClicked(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }

    
    //MARK:- CNContactPickerDelegate Method
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
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



//MARK:- Searching Data
extension ContactsViewController
{
    func didChangeText(textField: UITextField) {
        
        if txtSearch.count > 0 {
            btnCancel.isHidden = false
            isSearch = true
        }
        else {
            btnCancel.isHidden = true
            isSearch = false
        }
        
        filterContentForSearchText(searchText: txtSearch.text!)
        self.tblViewContacts.reloadData()
        
    }
    
    
    
    func filterContentForSearchText(searchText: String) {
        
        arySearchList = self.contacts.filter { term in
            return term.name.lowercased().contains(searchText.lowercased())
        }
    }
}

// MARK:- Contacts Details
// Request to Access Contacts
extension ContactsViewController{
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
}
