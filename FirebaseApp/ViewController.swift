//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Paige Keller on 2/23/22.
//

import UIKit
import Firebase
import FirebaseFirestore
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    

    let db = Firestore.firestore()
   // var peopleArray: [String] = []
    //var scoresArray: [Int] = []
    var userArray: [User] = []
    var dataArray: [Data] = []
    var infoListener: ListenerRegistration!
    var scoreListener: ListenerRegistration!
    var youIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self
    
   

    }
        

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let docRef = db.collection("ClassClickerCollection").document("document")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                self.dataArray = dataDescription.first!.value as! [Data]
                self.userArray = []
                for data in self.dataArray {
                    
                                do {
                    
                                // Read/Get Data, Decoder
                                let decoder = JSONDecoder()
                    
                                  let u = try decoder.decode(User.self, from: data)
                                    self.userArray.append(u)
                                } catch {
                                    print("Unable to Encode Class (\(error))")
                                }
                    
                }
                
                
                var i = 0
                for each in self.userArray {
                    if each.name == UserDefaults.standard.string(forKey: "name") {
                        self.youIndex = i
                        print(self.youIndex)
                        break
                    }
                    i += 1
                }
                self.tableview.reloadData()

            } else {
                print("Document does not exist")
            }
           
           // self.tableview.reloadData()
        
        
        
        }
     
        
        
    //listener
        infoListener = db.collection("ClassClickerCollection").document("document").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                let docRef = self.db.collection("ClassClickerCollection").document("document")

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()!
                        self.dataArray = dataDescription.first!.value as! [Data]
                        self.userArray = []
                        for data in self.dataArray {
                            
                                        do {
                            
                                        // Read/Get Data, Decoder
                                        let decoder = JSONDecoder()
                            
                                          let u = try decoder.decode(User.self, from: data)
                                            self.userArray.append(u)
                                        } catch {
                                            print("Unable to Encode Class (\(error))")
                                        }
                            let secondsToDelay = 1.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                self.tableview.reloadData()
                            }
                        }
                    }
                
                }
         
           
        }
    
    }
    
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        convoArray.remove(at: indexPath.row)
//        db.collection("conversation").document("6wIYwJ0Ktnp3rQhQAqPR").setData(["convoArray" : convoArray], merge: true)
//        tableview.reloadData()
//
//    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "myCell")!
       
        
        if userArray.count != 0 {
            
            cell.detailTextLabel?.text = "\(userArray[indexPath.row].score)"
        }
        cell.textLabel?.text = "\(userArray[indexPath.row].name)"
        
        cell.backgroundColor = UIColor.systemGray2
        if indexPath.row == youIndex {
            cell.backgroundColor = UIColor.systemPink
        }
        
        return cell
    }
    
    
    

//    func setArray() {
//        let docRef = db.collection("ClickerCollection").document("people")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()!
//                self.peopleArray = dataDescription.first!.value as! [String]
//
//            } else {
//                print("Document does not exist")
//            }
//        }
//
//    }


}
