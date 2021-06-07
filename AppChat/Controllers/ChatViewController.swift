//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = [
     Message(sender: "hongloi11@gmail.com", body: "Hey!"),
         Message(sender: "hongloi11@gmail.com", body: "Hello!"),
         Message(sender: "hongloi11@gmail.com", body: "What up?")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.delegate = self
        //get uiImageView Item connect to MessageCell and Messgaecell Identifier
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    func loadMessages(){
      
        db.collection(K.FStore.collectionName)
        .order(by: K.FStore.dateField)
        .addSnapshotListener() { (querySnapshot, err) in
            self.messages = []
            if let e = err {
                print("Error getting documents: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                for doc in snapshotDocuments{
//                    print(doc.data())
                    let data = doc.data()
                   if let messageSender = data[K.FStore.senderField] as? String,
                    let messageBody = data[K.FStore.bodyField] as? String
                {
                    let newMessage = Message(sender: messageSender, body: messageBody)
                    self.messages.append(newMessage)
                    
                    //refresh data tableview
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //show message form bottom to top
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }
                    }
                }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]){  (error) in
                if let e = error {
                    print("There was an issus saving data to firestore, \(e)")
                } else {
                    print("You saved data sucessfull")
                    //Create space when sent message
                    DispatchQueue.main.async {
                     self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            //Go to screen start
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
   
}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    //Handle with table cell and show data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as! MessageCell
        
//        cell.textLabel?.text = messages[indexPath.row].body;
        cell.label.text = message.body
        //This is a message form current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
    
}
//get value at selected
extension ChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
