//
//  ApiRequests.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 01.06.2021.
//

import Foundation
import Alamofire


protocol NetworkServicesProtocol: AnyObject {
  func getFriendList(userId: Int?, completion: @escaping ([FriendsModel]) -> Void)
  func getUserInfo(id: Int, completion: @escaping (UserModel) -> Void)
  func getUserGroups(completion: @escaping ([GroupsModel]) -> Void)
  func getPhoto(id: Int,completion: @escaping ([PhotosModel]) -> Void)
  func getNews(completion: @escaping (Response) -> Void)
}

class NetworkServices: NetworkServicesProtocol {
  
  let baseUrl = "https://api.vk.com/method/"
  let token = Session.shared.token
  let version = "5.131"
  
  func getFriendList(userId: Int?, completion: @escaping ([FriendsModel]) -> Void) {
    let parameters: Parameters
    if userId == nil {
      parameters = [
        "order": "hints",
        "fields": "nickname,photo_50,online",
        "access_token": token,
        "v": version]
    } else {
      parameters = [
        "user_id": userId!,
        "order": "hints",
        "fields": "photo_50,online",
        "access_token": token,
        "v": version]
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
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getUserInfo(id: Int, completion: @escaping (UserModel) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let parameters: Parameters = [
      "user_ids": id,
      "fields": "nickname,photo_200_orig,online,last_seen,status",
      "access_token": token,
      "v": version]
    let path = "users.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
      do {
        let user = try JSONDecoder().decode(UserModel.self, from: data)
        DispatchQueue.main.async {
          completion(user)
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getUserGroups(completion: @escaping ([GroupsModel]) -> Void) {
    let parameters: Parameters = [
      "extended": 1,
      "fields": "name,status",
      "access_token": token,
      "v": version]
    let path = "groups.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
      do {
        let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).response.items
        DispatchQueue.main.async {
          completion(groups)
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getPhoto(id: Int,completion: @escaping ([PhotosModel]) -> Void) {
    let parameters: Parameters = [
      "owner_id": id,
      "count": 199,
      "no_service_albums": 1,
      "photo_sizes": 1,
      "access_token": token,
      "v": version]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
      do {
        let photos = try JSONDecoder().decode(PhotoResponse.self, from: data).response.items
        DispatchQueue.main.async {
          completion(photos)
        }
      } catch {
        print(error)
      }
    }
  }
  
  func getNews(completion: @escaping (Response) -> Void) {
    let parameters: Parameters = [
       "filters": "post",
    //  "count": 5,
      "access_token": token,
      "v": version]
    let path = "newsfeed.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.data else { return }
    //  print(data.prettyJSON)
      do {
        let news = try JSONDecoder().decode(NewsFeed.self, from: data).response
        DispatchQueue.main.async {
          completion(news!)
        }
      } catch {
        print(error)
      }
   }
  }
  
}

