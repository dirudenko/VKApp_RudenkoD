//
//  TabBarController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class TabBarController: UITabBarController {

  func fillUsers() {
    let user1 = User(name: "Tim Cook", age: 60, avatar: UIImage(named: "Tim Cook")!, job: "Apple")
    let user2 = User(name: "Bill Gates", age: 65, avatar: UIImage(named: "Bill Gates")!, job: "ex-Microsoft")
    let user3 = User(name: "Elon Musk", age: 49, avatar: UIImage(named: "Elon Musk")!, job: "Tesla")
    let user4 = User(name: "Jeff Bezos", age: 57, avatar: UIImage(named: "Jeff Bezos")!, job: "Amazon")
    let user5 = User(name: "Jack Doursey", age: 44, avatar: UIImage(named: "Jack Doursey")!, job: "Twitter")
    
    let users: [User] = [user1, user2, user3, user4, user5]
    DataStorage.shared.usersArray.append(contentsOf: users)
  }
  
  func fillGroups() {
    let group1 = Group(name: "GeekBrains", description: "Группа для студентов GeekBrains", groupImage:  UIImage(named: "gb"))
    let group2 = Group(name: "Mobile Developer", description: "Группа для мобильных разработчиков", groupImage: UIImage(named: "mobile"))
    let group3 = Group(name: "iOS Developer", description: "Группа для iOS разработчиков", groupImage: UIImage(named: "swift"))
    let group4 = Group(name: "Forbes TOP 100", description: "Группа для членов Forbes TOP 100", groupImage: UIImage(named: "forbes"))
    let group5 = Group(name: "Summer Vacation", description: "Обсуждение грядущих отпусков", groupImage: nil)
    
    let allGroups: [Group] = [group1, group2, group3, group4, group5]
    let myGroups: [Group] = [group1, group5]
    DataStorage.shared.allGroup.append(contentsOf: allGroups)
    DataStorage.shared.myGroup.append(contentsOf: myGroups)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUsers()
        fillGroups()
    }
}
