//
//  ViewController2.swift
//  FirebaseApp
//
//  Created by Paige Keller on 3/8/22.
//

import UIKit
import Firebase
import FirebaseFirestore
class Clicker: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    let db = Firestore.firestore()
    var user: User!
    var dataArray: [Data] = []
    var count = 0
    var index = 0
    var scoreListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("before")
        
      
        
        
                // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreLabel.text = "\(count)"
        
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
        
        let docRef = db.collection("ClassClickerCollection").document("document")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                self.dataArray = dataDescription.first!.value as! [Data]
                
                var i = 0
                for data in self.dataArray {
                    do {
        
                    // Read/Get Data, Decoder
                    let decoder = JSONDecoder()
                      let u = try decoder.decode(User.self, from: data)
                        if u.name == UserDefaults.standard.string(forKey: "name") {
                        self.user = u
                            self.count = self.user.score
                            self.index = i
                        }
                    } catch {
                        print("Unable to Encode Class (\(error))")
                    }
                    i += 1
                }
                }
                }
               
        }
    
        //listener
            scoreListener = db.collection("ClassClickerCollection").document("document").addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("changesInScore")
                    self.scoreLabel.text = "\(self.count)"
                    }
            }
        
        self.btn.isHidden = false
    }
    
  
    @IBAction func clickAction(_ sender: UIButton) {
       
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
        count += 1
            user.score = count
        
            do {
                    // Create JSON Encoder
                    let encoder = JSONEncoder()
            
                    // Encode Note
                    let data = try encoder.encode(user)
                dataArray[index] = data
                    } catch {
                            print("Unable to Encode Class (\(error))")
                        }
            
        db.collection("ClassClickerCollection").document("document").setData(["array" : dataArray], merge: true)
        }
    }
    
    
}
