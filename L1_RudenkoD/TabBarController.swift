//
//  TabBarController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class TabBarController: UITabBarController {

  func fillUsers() {
    let user1 = User(name: "Tim Cook", age: 60, avatar: UIImage(named: "Tim Cook")!, photoArray: [UIImage(named: "Tim Cook 1")!, UIImage(named: "Tim Cook 2")!, UIImage(named: "Tim Cook 3")!, UIImage(named: "Tim Cook 4")!], job: "Apple")
    let user2 = User(name: "Bill Gates", age: 65, avatar: UIImage(named: "Bill Gates")!, photoArray: [UIImage(named: "Bill Gates 1")!, UIImage(named: "Bill Gates 2")!, UIImage(named: "Bill Gates 3")!, UIImage(named: "Bill Gates 4")!, UIImage(named: "Bill Gates 5")!], job: "ex-Microsoft")
    let user3 = User(name: "Elon Musk", age: 49, avatar: UIImage(named: "Elon Musk")!, photoArray: [UIImage(named: "Elon Musk 1")!, UIImage(named: "Elon Musk 2")!, UIImage(named: "Elon Musk 3")!, UIImage(named: "Elon Musk 4")!], job: "Tesla, SpaceX")
    let user4 = User(name: "Jeff Bezos", age: 57, avatar: UIImage(named: "Jeff Bezos")!, photoArray: [UIImage(named: "Jeff Bezos 1")!, UIImage(named: "Jeff Bezos 2")!, UIImage(named: "Jeff Bezos 3")!, UIImage(named: "Jeff Bezos 4")!, UIImage(named: "Jeff Bezos 5")!], job: "Amazon")
    let user5 = User(name: "Jack Doursey", age: 44, avatar: UIImage(named: "Jack Doursey")!,photoArray: [UIImage(named: "Jack Doursey 1")!, UIImage(named: "Jack Doursey 2")!, UIImage(named: "Jack Doursey 3")!, UIImage(named: "Jack Doursey 4")!, UIImage(named: "Jack Doursey 5")!], job: "Twitter")
    let user6 = User(name: "Sergey Brin", age: 47, avatar: UIImage(named: "Sergey Brin")!,photoArray: [UIImage(named: "Sergey Brin 1")!, UIImage(named: "Sergey Brin 2")!, UIImage(named: "Sergey Brin 3")!, UIImage(named: "Sergey Brin 4")!], job: "Google")
    
    let users: [User] = [user1, user2, user3, user4, user5, user6]
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
