//
//  DataStorage.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

final class DataStorage: NSObject {
  static let shared = DataStorage()
  private override init() {
    super.init()
  }
  
  var usersArray = [oldUser]()
  //var newUsersArray = [Item]()
  //var myFriendsArray = [User]()
  //var sortedChars = [String]()
  //var charIndex = Int()
  var allGroup = [oldGroup]()
  var myGroup = [oldGroup]()
  var groupedPeople = [(char:Character, User:[UsersModel])]()
  //var postedNews = [Post]()
}
