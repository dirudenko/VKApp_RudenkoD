//
//  ApiRequests.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 01.06.2021.
//

import Foundation
import Alamofire
import RealmSwift

class ApiRequests: UIViewController {
  
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
      do {
      let users = try JSONDecoder().decode(FriendsResponse.self, from: data).response.items
      DispatchQueue.main.async {
        self.saveUsersData(users)
        completion(users)
      }
      } catch {
        return
      }
    }
  }
  
  func getUserInfo(id: Int, completion: @escaping (User) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let parameters: Parameters = [
      "user_ids": id,
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
        self.saveCurrentUserData(user)
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
        self.saveGroupData(groups)
        completion(groups)
      }
    }
  }
  
  func getPhoto(id: Int,completion: @escaping ([Item]) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "owner_id": id,
      "no_service_albums": 1,
      "access_token": token,
      "v": "5.77"]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      do {
      let photos = try JSONDecoder().decode(Photos.self, from: data).response.items
      DispatchQueue.main.async {
        self.savePhotosData(photos)
        completion(photos)
      }
      } catch {
        return
      }
    }
  }
}

extension ApiRequests {
  
  func saveUsersData(_ users: [Users]) {
    let realm = try! Realm()
    try? realm.write {
      realm.add(users)
    }
  }
  
  func saveCurrentUserData(_ user: User) {
    let realm = try! Realm()
    try? realm.write {
      realm.add(user)
    }
  }
  
  func saveGroupData(_ group: [Groups]) {
    let realm = try! Realm()
    try? realm.write {
      realm.add(group)
    }
  }
  
  func savePhotosData(_ photos: [Item]) {
    let realm = try! Realm()
    try? realm.write {
      realm.add(photos)
    }
  }
}
