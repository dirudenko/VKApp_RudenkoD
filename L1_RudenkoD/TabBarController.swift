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
    DataStorage.shared.usersArray.append(user1)
    let user2 = User(name: "Bill Gates", age: 65, avatar: UIImage(named: "Bill Gates")!, job: "ex-Microsoft")
    DataStorage.shared.usersArray.append(user2)
    let user3 = User(name: "Elon Musk", age: 49, avatar: UIImage(named: "Elon Musk")!, job: "Tesla")
    DataStorage.shared.usersArray.append(user3)
    let user4 = User(name: "Jeff Bezos", age: 57, avatar: UIImage(named: "Jeff Bezos")!, job: "Amazon")
    DataStorage.shared.usersArray.append(user4)
    let user5 = User(name: "Jack Doursey", age: 44, avatar: UIImage(named: "Jack Doursey")!, job: "Twitter")
    DataStorage.shared.usersArray.append(user5)
    
//    for item in DataStorage.shared.myFriendsArray {
//      if DataStorage.shared.usersArray[index] == item {
//        isEnable = true
//      } else { index += 1 }
//    }
//      if !isEnable {
//        DataStorage.shared.myFriendsArray.append = DataStorage.shared.usersArray[index]
//      }
  }
  
  
  func fillGroups() {
    let group1 = Group(name: "GeekBrains", description: "Группа для студентов GeekBrains", groupImage:  UIImage(named: "gb"), status: true)
    let group2 = Group(name: "Mobile Developer", description: "Группа для мобильных разработчиков", groupImage: UIImage(named: "mobile"), status: false)
    let group3 = Group(name: "iOS Developer", description: "Группа для iOS разработчиков", groupImage: UIImage(named: "swift"), status: false)
    let group4 = Group(name: "Forbes TOP 100", description: "Группа для членов Forbes TOP 100", groupImage: UIImage(named: "forbes"), status: false)
    let group5 = Group(name: "Summer Vacation", description: "Обсуждение грядущих отпусков", groupImage: nil, status: true)
    DataStorage.shared.allGroup.append(group1)
    DataStorage.shared.myGroup.append(group1)
    DataStorage.shared.allGroup.append(group2)
    DataStorage.shared.allGroup.append(group3)
    DataStorage.shared.allGroup.append(group4)
    DataStorage.shared.allGroup.append(group5)
    DataStorage.shared.myGroup.append(group5)


  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUsers()
        fillGroups()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
