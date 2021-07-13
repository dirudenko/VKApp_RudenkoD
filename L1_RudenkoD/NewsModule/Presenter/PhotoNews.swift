//
//  PhotoNews.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 09.07.2021.
//

import UIKit

final class PhotoNews: NewsTableViewController {
  
  //private var items = [ResponseItem]()
  //private var groups = [Group]()
  //private var profiles = [Profile]()
 // private var indexPath = IndexPath()
  
  func testtest(indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
    var name, string: String?
    guard let source = items[indexPath.section].sourceID else { return UITableViewCell() }
    
    if source < 0 {
      groups.forEach {
        if $0.id == abs(source) {
          name = $0.name
          string = $0.photo100
        }
      }
    } else {
      profiles.forEach {
        if $0.id == source {
          name = $0.name
          string = $0.photo100
        }
      }
    }
    guard let avatarString = URL(string: string!) else { return UITableViewCell() }
    let image = asyncPhoto(cellImage: cell.userImage, url: avatarString)
    //let image1 = newAsyncPhoto(tableView: self.tableView, url: avatarString)
    let posted = unixTimeConvertion(unixTimeInt: items[indexPath.section].date ?? 0)
    cell.configure(image: image, name: name, posted: posted)
    return cell
  }
  
  
  func test(indexPath: IndexPath) -> UITableViewCell {
  switch indexPath.row {
  case 0:
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
    var name, string: String?
    guard let source = items[indexPath.section].sourceID else { return UITableViewCell() }
    
    if source < 0 {
      groups.forEach {
        if $0.id == abs(source) {
          name = $0.name
          string = $0.photo100
        }
      }
    } else {
      profiles.forEach {
        if $0.id == source {
          name = $0.name
          string = $0.photo100
        }
      }
    }
    guard let avatarString = URL(string: string!) else { return UITableViewCell() }
    let image = asyncPhoto(cellImage: cell.userImage, url: avatarString)
   // let image1 = newAsyncPhoto(tableView: self.tableView, url: avatarString)
    let posted = unixTimeConvertion(unixTimeInt: items[indexPath.section].date ?? 0)
    cell.configure(image: image, name: name, posted: posted)
    return cell
  case 1:
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
   
      let textNews = items[indexPath.section].photos?.items?.first?.text
      cell.configure(text: textNews)
      return cell
  
    
  
  case 2:
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
   
   
      guard let imageString = findPhotoURL(item: items[indexPath.section]) else { return UITableViewCell() }
      let imageNews = asyncPhoto(cellImage: cell.newsImage, url: imageString)
      cell.configure(image: imageNews)
      return cell
    
    
  case 3:
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsUtilityCell", for: indexPath) as! NewsUtilityCell
    let shared = String(items[indexPath.section].reposts?.count ?? 0)
    let views = String(items[indexPath.section].views?.count ?? 0)
    let comments = String(items[indexPath.section].comments?.count ?? 0)
    let likes = String(items[indexPath.section].likes?.count ?? 0)
    cell.configure(likes: likes, shared: shared, view: views, comments: comments)
    return cell
  case 4:
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSeparatorCell", for: indexPath) as! NewsSeparatorCell
    return cell
  default:
    return UITableViewCell()
  }
  }
  
  
  
  
  
}


//extension PhotoNews: NewsProtocol {
//  func success() {
//    guard let items = presenter.items,
//          let profiles = presenter.profiles,
//          let groups = presenter.groups else { return }
//    DispatchQueue.main.async {
//      self.items = items
//      self.profiles = profiles
//      self.groups = groups
//      self.tableView.reloadData()
//    }
//
//  }
//}
