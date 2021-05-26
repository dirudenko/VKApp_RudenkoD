//
//  AuthViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 26.05.2021.
//

import UIKit
import WebKit
import Alamofire

class AuthViewController: UIViewController, WKNavigationDelegate {
  
  @IBOutlet weak var authWebView: WKWebView! {
    didSet {
      authWebView.navigationDelegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "oauth.vk.com"
    urlComponents.path = "/authorize"
    urlComponents.queryItems = [
      URLQueryItem(name: "client_id", value: "7864517"),
      URLQueryItem(name: "display", value: "mobile"),
      URLQueryItem(name: "redirect_uri",
                   value:"https://oauth.vk.com/blank.html"),
      URLQueryItem(name: "scope", value: "262150"),
      URLQueryItem(name: "response_type", value: "token"),
      URLQueryItem(name: "v", value: "5.131")
    ]
    let request = URLRequest(url: urlComponents.url!)
    authWebView.load(request)
  }
}

extension AuthViewController {
  func webView(_ webView: WKWebView,
               decidePolicyFor navigationResponse:
                WKNavigationResponse,
               decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    guard let url = navigationResponse.response.url,
          url.path == "/blank.html",
          let fragment = url.fragment
    else {
      decisionHandler(.allow)
      return
    }
    
    let params = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=") }
      .reduce([String: String]()) { result, param in
        var dict = result
        let key = param[0]
        let value = param[1]
        dict[key] = value
        return dict
      }
    let token = params["access_token"]
    guard let token = token else { return }
    Session.shared.token  = token
    decisionHandler(.cancel)
    
    getInfo(method: "friends.get")
    getPhoto()
    getInfo(method: "groups.get")
    getGroup(groupName: "GeekBrains")
    
  }
 // Получение друзей и групп
  func getInfo(method: String){
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "access_token": token,
      "v": "5.131"]
    let path = method
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseJSON {
      response in
      print(response.value)
    }
  }
  // Получение фотографий
  func getPhoto() {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "access_token": token,
      "v": "5.77"]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseJSON {
      response in
      print(response.value)
    }
  }
  // Получение групп по поисковому запросу
  func getGroup(groupName: String) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
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




