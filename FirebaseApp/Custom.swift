//
//  Custom.swift
//  FirebaseApp
//
//  Created by Paige Keller on 3/8/22.
//

import Foundation
class Custom: Codable {
    
    var string: String = "hello world"
    var number: Int = 100
    var myArray: [String] = ["ponies", "are", "lit"]
    
    func sayHi() {
        print("hello my world im in a function")
    }
    
    
    // HOW TO SAVE CUSTOM CLASS TO FIREBASE \/
    
   // let c = Custom()
  //        do {
  //        // Create JSON Encoder
  //        let encoder = JSONEncoder()
  //
  //        // Encode Note
  //        let d = try encoder.encode(c)
  //            print("here")
  //            db.collection("variables").document("PbSF6wFPHtTOpTlYyxKf").setData(["trial" : d], merge: true)
  //        } catch {
  //                print("Unable to Encode Class (\(error))")
  //            }
    
    
    
//    let docRef = db.collection("variables").document("PbSF6wFPHtTOpTlYyxKf")
//
//    docRef.getDocument { (document, error) in
//
//        if let document = document, document.exists {
//            let dataDescription = document.data()!
//
//            let temp = dataDescription["trial"] as! Data
//
//            do {
//
//            // Read/Get Data, Decoder
//            let decoder = JSONDecoder()
//
//              let plswork = try decoder.decode(Custom.self, from: temp)
//                print(plswork.myArray)
//                plswork.sayHi()
//            } catch {
//                print("Unable to Encode Class (\(error))")
//            }
//        }
//    }
    
    
}
