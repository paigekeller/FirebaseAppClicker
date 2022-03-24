//
//  LoginView.swift
//  FirebaseApp
//
//  Created by Paige Keller on 3/15/22.
//

import UIKit

import Firebase
import FirebaseFirestore
class LoginView: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var temp: [String]!
    var score: [Int] = []
    let db = Firestore.firestore()
    var userArray: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //UserDefaults.standard.set(false, forKey: "loggedIn")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
     
        view.addGestureRecognizer(tap)
        
    }
    
    
    
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //print(UserDefaults.standard.string(forKey: "name"))
        
        
        
        nameLabel.isHidden = true
        enterBtn.isHidden = false
        textField.isHidden = false
        
        
        if UserDefaults.standard.object(forKey: "loggedIn") == nil {
            UserDefaults.standard.set(false, forKey: "loggedIn")
           
        } else {
        
            if UserDefaults.standard.bool(forKey: "loggedIn") == false {
                //nothing
            } else {
                //true
                loggedIn()
            }
        }
        
        
        let docRef = db.collection("ClassClickerCollection").document("document")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                self.userArray = dataDescription.first!.value as! [Data]
            }
        }
        
        
    }
    
    
    @IBAction func newAccount(_ sender: UIButton) {
        unLog()
        textField.text = ""
    }
    
    
    @IBAction func enterAction(_ sender: UIButton) {
        if textField.text != "" {
            UserDefaults.standard.set(textField.text, forKey: "name")
        loggedIn()
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        
        let newUser = User(s: textField.text!)
        
               do {
               // Create JSON Encoder
               let encoder = JSONEncoder()
       
               // Encode Note
               let data = try encoder.encode(newUser)
                   userArray.append(data)
                   db.collection("ClassClickerCollection").document("document").setData(["array" : userArray], merge: true)
               } catch {
                       print("Unable to Encode Class (\(error))")
                   }
        
        //score.append(0)
       // print(score)
        
        //set it to firebase
        //names
//        let docRef = db.collection("ClickerCollection").document("people")
//
//        docRef.getDocument { [self] (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()!
//
//                    temp = dataDescription.first!.value as? [String]
//
//
//
//
//                temp.append(self.textField.text!)
//                self.db.collection("ClickerCollection").document("people").setData(["names" : temp!], merge: true)
//
//            } else {
//                print("Document does not exist")
//            }
//            //scores
//            let docRef2 = db.collection("ClickerCollection").document("numbers")
//
//            docRef2.getDocument { [self] (document, error) in
//                if let document = document, document.exists {
//                    let dataDescription = document.data()!
//
//                        score = dataDescription.first!.value as! [Int]
//
//
//
//
//                    score.append(0)
//                    self.db.collection("ClickerCollection").document("numbers").setData(["nums" : score], merge: true)
//
//                } else {
//                    print("Document does not exist")
//                }
//
//
//        }
//    }
        }
    }
    
    
    
    func loggedIn() {
        
        enterBtn.isHidden = true
        textField.isHidden = true
        nameLabel.isHidden = false
        nameLabel.text = "Hello, \(UserDefaults.standard.string(forKey: "name")!) You Are Already Logged In!"
    }
    
    func unLog() {
        enterBtn.isHidden = false
        textField.isHidden = false
        nameLabel.isHidden = true
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    
}
