//
//  ApiRequests.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 01.06.2021.
//

import Foundation
import Alamofire


class ApiRequests {
  
  let baseUrl = "https://api.vk.com/method/"
  let token = Session.shared.token
  
  func getFriendList(userId: Int?, completion: @escaping ([Users]) -> Void) {
    let parameters: Parameters
    if userId == nil {
     parameters = [
      "order": "hints",
      "fields": "nickname,photo_50,online",
      "access_token": token,
      "v": "5.131"]
    } else {
      parameters = [
        "user_id": userId!,
        //"count": 5,
        "order": "hints",
        "fields": "photo_50,online",
        "access_token": token,
        "v": "5.131"]
    }
    let path = "friends.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      let users = try! JSONDecoder().decode(FriendsResponse.self, from: data).response.items
      DispatchQueue.main.async {
        completion(users)
      }
    }
  }
  
  func getUserInfo(friendId: Int, completion: @escaping (User) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let parameters: Parameters = [
      "user_ids": friendId,
      "fields": "nickname,photo_200_orig,online,last_seen",
      "access_token": token,
      "v": "5.131"]
    let path = "users.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      let user = try! JSONDecoder().decode(User.self, from: data)
      DispatchQueue.main.async {
        completion(user)
      }
    }
  }
  
  func getUserGroups(completion: @escaping ([Groups]) -> Void) {
    let parameters: Parameters = [
      "extended": 1,
      "fields": "name,status",
      "access_token": token,
      "v": "5.131"]
    let path = "groups.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      //  print(data.prettyJSON!)
      let groups = try! JSONDecoder().decode(GroupsResponse.self, from: data).response.items
      DispatchQueue.main.async {
        completion(groups)
      }
    }
  }
  
  func findGroup(groupName: String) {
    let parameters: Parameters = [
      "q": groupName,
      "count": 10,
      "access_token": token,
      "v": "5.54"]
    let path = "groups.search"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseJSON {
      response in
      print(response.value)
    }
  }
  
}
