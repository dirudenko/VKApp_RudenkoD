//
//  NewsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  private var news = Response(items: nil, profiles: nil, groups: nil, nextFrom: nil)
  private var friendIndex: Int?
  private let networkService = NetworkServices()
  
  var presenter: NewsPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeView()
    presenter = NewsPresenter(view: self, networkService: networkService)
  }
  
  func makeView() {
    let nibFile = UINib(nibName: "NewsSourceCell", bundle: nil)
    tableView.register(nibFile, forCellReuseIdentifier: "NewsSourceCell")
    let textNib = UINib(nibName: "NewsTextCell", bundle: nil)
    tableView.register(textNib, forCellReuseIdentifier: "NewsTextCell")
    let utilNib = UINib(nibName: "NewsUtilityCell", bundle: nil)
    tableView.register(utilNib, forCellReuseIdentifier: "NewsUtilityCell")
    let imageNib = UINib(nibName: "NewsImageCell", bundle: nil)
    tableView.register(imageNib, forCellReuseIdentifier: "NewsImageCell")
    let separatorNib = UINib(nibName: "NewsSeparatorCell", bundle: nil)
    tableView.register(separatorNib, forCellReuseIdentifier: "NewsSeparatorCell")
    tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getNews()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return news.items?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let profiles = news.profiles,
          let groups = news.groups,
          let items = news.items else { return UITableViewCell() }
    
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
      let posted = unixTimeConvertion(unixTimeInt: items[indexPath.section].date ?? 0)
      cell.configure(image: image, name: name, posted: posted)
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
      let textNews = items[indexPath.section].text
      cell.configure(text: textNews)
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
      guard let imageString = findURL(item: items[indexPath.section].attachments) else { return UITableViewCell() }
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
      cell.delegate = self
      return cell
    case 4:
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSeparatorCell", for: indexPath) as! NewsSeparatorCell
      return cell
    default:
      return UITableViewCell()
    }
  }
}

extension NewsTableViewController {
  func findURL(item: [Attachment]?) -> URL? {
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
  
  func unixTimeConvertion(unixTimeInt: Int) -> String {
    let unixTime = Double(unixTimeInt)
    let time = NSDate(timeIntervalSince1970: unixTime)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
    dateFormatter.dateFormat = "hh:mm a"
    let dateAsString = dateFormatter.string(from: time as Date)
    dateFormatter.dateFormat = "h:mm a"
    let date = dateFormatter.date(from: dateAsString)
    dateFormatter.dateFormat = "HH:mm"
    let date24 = dateFormatter.string(from: date!)
    return date24
  }
}

extension NewsTableViewController: NewsProtocol {
  func success() {
    guard let news = presenter.news else { return } 
    self.news = news
    self.tableView.reloadData()
  }
}

extension NewsTableViewController: NewsButtonsDelegate {
  
  func share() {
    let text = "Смотри, какой интересный текст"
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook ]
    self.present(activityViewController, animated: true, completion: nil)
  }
}
