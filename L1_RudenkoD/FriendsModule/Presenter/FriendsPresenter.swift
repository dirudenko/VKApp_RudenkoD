//
//  FriendsPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.06.2021.
//

import UIKit
import RealmSwift
import Alamofire

protocol FriendsProtocol: AnyObject {
  func success()
}

protocol FriendsPresenterProtocol: AnyObject {
  init(view: FriendsProtocol)
  func getFriends()
  var friends: Results<FriendsModel>? {get set}
}

class FriendsPresenter: Operation, FriendsPresenterProtocol {
  
  var friends: Results<FriendsModel>?
  let view: FriendsProtocol
  let tableview = FriendsListViewController()
  let queue = OperationQueue()

 
  
  private var request: DataRequest {
      let baseUrl = "https://api.vk.com/method/"
      let token = Session.shared.token
      let version = "5.131"
      
      let parameters: Parameters
        parameters = [
          "order": "hints",
          "fields": "nickname,photo_50,online",
          "access_token": token,
          "v": version]
      
      let path = "friends.get"
      let url = baseUrl + path
      return AF.request(url, method: .get, parameters: parameters)
    
  }
  
  required init(view: FriendsProtocol) {
    self.view = view
  }
  
  func getFriends() {
    
    queue.qualityOfService = .background
    
    let getData = GetDataOperation(request: request)
    queue.addOperation(getData)
    
    let parseData = ParseDataOperation()
    parseData.addDependency(getData)
    queue.addOperation(parseData)
    
    let saveData = SaveDataOperation()
    saveData.addDependency(parseData)
    queue.addOperation(saveData)
    
    
    let readData = ReadDataOperation()
    readData.addDependency(saveData)
    OperationQueue.main.addOperation(readData)
    readData.completionBlock = { [weak self] in
      self?.friends = readData.friends
      OperationQueue.main.addOperation {
        self?.view.success()
      }
    }
  }
}
