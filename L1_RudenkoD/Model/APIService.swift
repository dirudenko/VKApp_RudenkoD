//
//  ApiRequests.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 01.06.2021.
//

import Foundation
import Alamofire
import RealmSwift

class APIService: UIViewController {
  
  let baseUrl = "https://api.vk.com/method/"
  let token = Session.shared.token
  
  func getFriendList(userId: Int?, completion: @escaping ([UsersModel]) -> Void) {
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
      guard let data = response.data else { return }
      do {
        let users = try JSONDecoder().decode(FriendsResponse.self, from: data).response.items
        DispatchQueue.main.async {
          completion(users)
          self.saveUsersData(users)
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getUserInfo(id: Int, completion: @escaping (User) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let parameters: Parameters = [
      "user_ids": id,
      "fields": "nickname,photo_200_orig,online,last_seen,status",
      "access_token": token,
      "v": "5.131"]
    let path = "users.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
      do {
        let user = try JSONDecoder().decode(User.self, from: data)
        DispatchQueue.main.async {
          self.saveCurrentUserData(user)
          completion(user)
        }
      } catch {
        print(error)
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
      guard let data = response.data else { return }
      do {
        let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).response.items
        DispatchQueue.main.async {
          completion(groups)
          self.saveGroupData(groups)
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getPhoto(id: Int,completion: @escaping ([Item]) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "owner_id": id,
      "count": 199,
      "no_service_albums": 1,
      "access_token": token,
      "v": "5.77"]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
      do {
        let photos = try JSONDecoder().decode(Photos.self, from: data).response.items
        DispatchQueue.main.async {
          self.savePhotosData(photos)
          completion(photos)
        }
      } catch {
        print(error)
      }
    }
  }
}

extension APIService {
  
  func saveUsersData(_ users: [UsersModel]) {
    let realm = try! Realm()
    do {
      realm.beginWrite()
      realm.add(users)
      try realm.commitWrite()
    } catch  {
      print(error)
    }
    print(realm.configuration.fileURL)
  }
  
  func saveCurrentUserData(_ user: User) {
    let realm = try! Realm()
    do {
      realm.beginWrite()
      realm.add(user)
      try realm.commitWrite()
    } catch  {
      print(error)
    }
  }
  
  func saveGroupData(_ group: [Groups]) {
    let realm = try! Realm()
    do {
      realm.beginWrite()
      realm.add(group)
      try realm.commitWrite()
    } catch  {
      print(error)
    }
  }
  
  func savePhotosData(_ photos: [Item]) {
    let realm = try! Realm()
    do {
      realm.beginWrite()
      realm.add(photos)
      try realm.commitWrite()
    } catch  {
      print(error)
    }
  }
}
