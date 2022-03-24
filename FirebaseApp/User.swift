//
//  User.swift
//  FirebaseApp
//
//  Created by Paige Keller on 3/23/22.
//

import Foundation
class User: Codable {

    var name: String = "hello world"
    var score: Int = 0
   
    init(s: String) {
        name = s
    }
    
    var NewClass: Custom = Custom()
    
    func sayHi() {
        print("hello my world im in a function")
    }
}
