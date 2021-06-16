//
//  FBModel.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 15.06.2021.
//

import Foundation
import FirebaseDatabase

class FBGroupModel {
  var descr: String
  var groups: String
  var photo: String
  var ref: DatabaseReference?
  
  init(descr: String, groups: String, photo: String) {
    self.descr = descr
    self.groups = groups
    self.photo = photo
    ref = nil
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: Any],
      let descr  = value["descr"] as? String,
      let groups = value["name"] as? String,
      let photo = value["photo"] as? String
    else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.descr = descr
    self.groups = groups
    self.photo = photo
  }
  
  func toAnyObject() -> [AnyHashable: Any] {
    return [ "name": groups, "descr": descr, "photo": photo  ] as [AnyHashable: Any]
  }
  
}


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
