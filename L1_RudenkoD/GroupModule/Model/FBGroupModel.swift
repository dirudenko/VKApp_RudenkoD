//
//  FBGroupModel.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 23.06.2021.
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
