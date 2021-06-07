//
//  FIndEmailController.swift
//  AppChat
//
//  Created by CNTT on 6/7/21.
//  Copyright © 2021 fit.tdc.vn. All rights reserved.
//

import UIKit
import Firebase

class FIndEmailController: UIViewController {
    
    @IBOutlet weak var lblFindName: UITextField!
    
    @IBOutlet weak var btnFindName: UIButton!
     let db = Firestore.firestore()
   
    @IBAction func sendFindFriend(_ sender: UIButton) {
        db.collection(K.FStore.collectionName)
            .addSnapshotListener() { (querySnapshot, err) in
                if let e = err {
                    print("Error getting documents: \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            if let messageSender = data[K.FStore.senderField] as? String
//                                let messageBody = data[K.FStore.bodyField] as? String
                            {
                                if messageSender == self.lblFindName.text {
                                    self.performSegue(withIdentifier: "FindToChat", sender: self)
                                    break
                                   
                                }
                                else{
                                    let alert = UIAlertController(title: "Error", message: "Không có người bạn này", preferredStyle: UIAlertController.Style.alert)
                                    
                                    // add an action (button)
                                    alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
                                    
                                    // show the alert
                                    self.present(alert, animated: true, completion: nil)
                                    break
                                }
                            }
                        }
                    }
                }
        }
    }
}
