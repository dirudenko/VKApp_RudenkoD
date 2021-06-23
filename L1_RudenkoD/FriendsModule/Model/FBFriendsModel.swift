//
//  FBModel.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 15.06.2021.
//

import Foundation
import FirebaseDatabase

class FBUserModel {
 
  var lastName: String
  var photo50: String
  var firstName: String
  var online: Int
  var ref: DatabaseReference?
  var name: String {
  firstName + " " + lastName
}
  
  internal init(lastName: String, photo50: String, firstName: String, online: Int, ref: DatabaseReference? = nil) {
    self.lastName = lastName
    self.photo50 = photo50
    self.firstName = firstName
    self.online = online
    self.ref = nil
    
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: Any],
      let lastName  = value["lastName"] as? String,
      let firstName = value["firstName"] as? String,
      let online = value["online"] as? Int,
      let photo50 = value["photo50"] as? String
    else {
      return nil
    }
    self.lastName = lastName
    self.photo50 = photo50
    self.firstName = firstName
    self.online = online
  }
  
  func toAnyObject() -> [AnyHashable: Any] {
    return [ "firstName": firstName, "lastName": lastName, "photo50": photo50, "online": online   ] as [AnyHashable: Any]
  }
  
}
