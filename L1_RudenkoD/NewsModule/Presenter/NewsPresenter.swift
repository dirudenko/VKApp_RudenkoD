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
  func getUpdatedNews(mostFreshNewsDate: Int, completion: @escaping ([ResponseItem], [Group], [Profile]) -> Void)
  func getInfinityNews(startFrom: String, completion: @escaping ([ResponseItem], [Group], [Profile], String) -> Void)
  var items: [ResponseItem]? {get set}
  var groups: [Group]? {get set}
  var profiles: [Profile]? {get set}
  var nextFrom: String? {get set}
}

class NewsPresenter: NewsPresenterProtocol {
  
  
  var groups: [Group]?
  var profiles: [Profile]?
  var items: [ResponseItem]?
  let view: NewsProtocol
  weak var networkService: NetworkServicesProtocol!
  var nextFrom: String?
  
  required init(view: NewsProtocol, networkService: NetworkServicesProtocol ) {
    self.view = view
    self.networkService = networkService
  }
  
  func getNews(filters: PhotoFilters) {
    networkService.getNews(filters: filters, startFrom: nil, startTime: nil) { [weak self]  items, groups , profiles, nextFrom  in
      guard let self = self else { return }
      self.groups = groups
      self.items = items
      self.profiles = profiles
      self.nextFrom = nextFrom
      self.view.success()
    }
  }
  
  func getUpdatedNews(mostFreshNewsDate: Int, completion: @escaping ([ResponseItem], [Group], [Profile]) -> Void) {
    networkService.getNews(filters: .post, startFrom: nil, startTime: mostFreshNewsDate + 1) { items, groups, profiles, nextFrom  in
    guard items.count > 0 else {
      print("No update")
      return
    }
    completion(items, groups, profiles)
  }
}
  
  func getInfinityNews(startFrom: String, completion: @escaping ([ResponseItem], [Group], [Profile], String) -> Void) {
    networkService.getNews(filters: .post, startFrom: startFrom, startTime: nil) {items, groups, profiles, nextFrom in
      completion(items, groups, profiles, nextFrom)
    }
  }
}


