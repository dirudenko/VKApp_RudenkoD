//
//  Extensions.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 10.07.2021.
//

import UIKit

extension NewsTableViewController {
  
  func configureHeader(cell: NewsSourceCell, source: Int, indexPath: IndexPath, filter: PhotoFilters) {
    var name, string, posted: String?
    var url: URL?
    let dispatchGroup = DispatchGroup()
    DispatchQueue.global().async(group: dispatchGroup) {
      if source < 0 {
        self.groups.forEach {
          if $0.id == abs(source) {
            name = $0.name
            string = $0.photo100
          }
        }
      } else {
        self.profiles.forEach {
          if $0.id == source {
            name = $0.name
            string = $0.photo100
          }
        }
      }
      guard let string = string else { return }
      url = URL(string: string)
      //let image = asyncPhoto(cellImage: cell.userImage, url: avatarString)
      posted = self.unixTimeConvertion(unixTimeInt: self.items[indexPath.section].date ?? 0)
    }
    dispatchGroup.notify(queue: .main) {
      cell.configure(url: url, name: name, posted: posted)
    }
  }
  
  func configureText(cell: NewsTextCell, indexPath: IndexPath, filter: PhotoFilters) {
    if filter == .photo {
      let textNews = items[indexPath.section].photos?.items?.first?.text
      cell.configure(text: textNews)
    }
    else {
      let textNews = items[indexPath.section].text
      cell.configure(text: textNews)
    }
  }
  
  func configurePhoto(cell: NewsImageCell, indexPath: IndexPath, filter: PhotoFilters) {
    if filter == .photo {
      guard let imageString = findPhotoURL(item: items[indexPath.section]) else { return }
      let imageNews = asyncPhoto(cellImage: cell.newsImage, url: imageString)
      cell.configure(image: imageNews)
    }
    else {
      guard let imageString = findPostURL(item: items[indexPath.section].attachments) else { return }
      let imageNews = asyncPhoto(cellImage: cell.newsImage, url: imageString)
      cell.configure(image: imageNews)
    }
  }
  
  func configureUtility(cell: NewsUtilityCell, indexPath: IndexPath, filter: PhotoFilters) {
    if filter == .photo {
      let shared = String(items[indexPath.section].photos?.items?.first?.reposts?.count ?? 0)
      let views = String( 0)
      let comments = String(items[indexPath.section].photos?.items?.first?.comments?.count ?? 0)
      let likes = String(items[indexPath.section].photos?.items?.first?.likes?.count ?? 0)
      cell.configure(likes: likes, shared: shared, view: views, comments: comments)
    }
    else {
      let shared = String(items[indexPath.section].reposts?.count ?? 0)
      let views = String(items[indexPath.section].views?.count ?? 0)
      let comments = String(items[indexPath.section].comments?.count ?? 0)
      let likes = String(items[indexPath.section].likes?.count ?? 0)
      cell.configure(likes: likes, shared: shared, view: views, comments: comments)
    }
  }
  
  func findPostURL(item: [Attachment]?) -> URL? {
    var url = String()
    guard let item = item else {return URL(string: url)}
    for item in item {
      item.photo?.sizes?.forEach {
        if $0.type == "r" {
          url = $0.url!
        }
      }
    }
    return URL(string: url)
  }
  
  func findPhotoURL(item: ResponseItem?) -> URL? {
    var url = String()
    guard let item = item else {return URL(string: url)}
    item.photos?.items?.first?.sizes!.forEach {
      if $0.type == "r" {
        url = $0.url!
      }
      
    }
    return URL(string: url)
  }
  
  func unixTimeConvertion(unixTimeInt: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimeInt))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    let strDate = dateFormatter.string(from: date)
    return strDate
  }
}
