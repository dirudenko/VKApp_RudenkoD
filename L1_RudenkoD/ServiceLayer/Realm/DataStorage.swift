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
  
  var allGroup = [oldGroup]()
  var myGroup = [oldGroup]()
  var groupedPeople = [(char:Character, User:[FriendsModel])]()
}
