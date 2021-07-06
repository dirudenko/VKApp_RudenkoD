//
//  NewsPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 23.06.2021.
//

import Foundation


protocol NewsProtocol: AnyObject {
  func success()
}

protocol NewsPresenterProtocol: AnyObject {
  init(view: NewsProtocol, networkService: NetworkServicesProtocol)
  func getNews()
  var news: Response? {get set}
}

class NewsPresenter: NewsPresenterProtocol {
  
  var news: Response?
  let view: NewsProtocol
  weak var networkService: NetworkServicesProtocol!
  
  
  required init(view: NewsProtocol, networkService: NetworkServicesProtocol ) {
    self.view = view
    self.networkService = networkService
  }
  
  func getNews() {
    networkService.getNews() { [weak self]  news in
      guard let self = self else { return }
      self.news = news
      self.view.success()
    }
   
  }
}



