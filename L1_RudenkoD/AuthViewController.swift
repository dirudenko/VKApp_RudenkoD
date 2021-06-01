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
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "oauth.vk.com"
    urlComponents.path = "/authorize"
    urlComponents.queryItems = [
      URLQueryItem(name: "client_id", value: "7867240"),
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
    if let token = token, !token.isEmpty {
      UserDefaults.standard.setValue(token, forKey: "vkToken")
      Session.shared.token = token
      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
      tabBarViewController.modalPresentationStyle = .fullScreen
      self.present(tabBarViewController, animated: true, completion: nil)
    }
    decisionHandler(.cancel)
  }
}


