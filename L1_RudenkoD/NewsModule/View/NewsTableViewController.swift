//
//  NewsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  private let nibIdentifier = "NewsTableViewCell"
  private var news = Response(items: nil, profiles: nil, groups: nil, nextFrom: nil)
  private var friendIndex: Int?
  private let networkService = NetworkServices()
  
  var presenter: NewsPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    self.tableView.rowHeight = UITableView.automaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    presenter = NewsPresenter(view: self, networkService: networkService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getNews()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.items?.count ?? 0
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! NewsTableViewCell
   
    guard let profiles = news.profiles,
          let groups = news.groups,
          let items = news.items else { return UITableViewCell() }
    
    var imageNews = UIImage()
    var name, string: String?
    guard let source = items[indexPath.row].sourceID else { return UITableViewCell() }
    if source < 0 {
      groups.forEach {
        if $0.id == abs(source) {
          name = $0.name!
          string = $0.photo100!
        }
      }
    } else {
      profiles.forEach {
        if $0.id == source {
          name = $0.firstName
          string = $0.photo100
        }
      }
    }
    guard let avatarString = URL(string: string!) else { return UITableViewCell() }
    let image = asyncPhoto(cellImage: cell.userImage, url: avatarString)
    let posted = unixTimeConvertion(unixTimeInt: items[indexPath.row].date ?? 0)
    let newNews = items[indexPath.row].text
    let shared = String(items[indexPath.row].reposts?.count ?? 0)
    let views = String(items[indexPath.row].views?.count ?? 0)
    let comments = String(items[indexPath.row].comments?.count ?? 0)
    cell.likeCounter.text = String(items[indexPath.row].likes?.count ?? 0)
    guard let imageString = findURL(item: items[indexPath.row].attachments) else { return UITableViewCell() }
      imageNews = asyncPhoto(cellImage: cell.imageForNews, url: imageString)
 
    
    cell.userImage.shadow(anyImage: imageNews, anyView: cell.viewForShadow, color: UIColor.black.cgColor)
    cell.configure(image: image, name: name, posted: posted, newNews: newNews, imageNews: imageNews, shared: shared, view: views, comments: comments)
    cell.delegate = self
    
    return cell
  }
  
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
    news = presenter.news!
    self.tableView.reloadData()
  }
}

extension NewsTableViewController: NewsButtonsDelegate {
  
  func share() {
    let text = "Смотри какой интересный текст"
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook ]
    self.present(activityViewController, animated: true, completion: nil)
  }
}
