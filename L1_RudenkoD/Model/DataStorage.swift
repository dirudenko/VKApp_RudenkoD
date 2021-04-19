//
//  DataStorage.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DataStorage: NSObject {
  static let shared = DataStorage()
  private override init() {
    super.init()
  }
  
  //var selectedUser = [Int]()
  
  var usersArray = [User]()
  var myFriendsArray = [User]()
  
  var allGroup = [Group]()
  var myGroup = [Group]()
  
  
  
  
}
