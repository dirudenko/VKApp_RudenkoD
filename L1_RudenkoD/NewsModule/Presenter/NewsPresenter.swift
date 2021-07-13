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
  func getNews(filters: PhotoFilters)
  var items: [ResponseItem]? {get set}
  var groups: [Group]? {get set}
  var profiles: [Profile]? {get set}
}

class NewsPresenter: NewsPresenterProtocol {
  
  var groups: [Group]?
  var profiles: [Profile]?
  var items: [ResponseItem]?
  let view: NewsProtocol
  weak var networkService: NetworkServicesProtocol!
  
  
  required init(view: NewsProtocol, networkService: NetworkServicesProtocol ) {
    self.view = view
    self.networkService = networkService
  }
  
  func getNews(filters: PhotoFilters) {
    networkService.getNews(filters: filters) { [weak self]  items, groups , profiles  in
      guard let self = self else { return }
      self.groups = groups
      self.items = items
      self.profiles = profiles
      self.view.success()
    }
   
  }
}



