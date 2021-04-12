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
    let group1 = Group(name: "test1", description: nil, groupImage: nil)
    let group2 = Group(name: "test2", description: nil, groupImage: nil)
    DataStorage.shared.allGroup.append(group1)
    DataStorage.shared.allGroup.append(group2)

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
