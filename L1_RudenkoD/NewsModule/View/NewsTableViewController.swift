//
//  NewsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  var items = [ResponseItem]()
  var groups = [Group]()
  var profiles = [Profile]()
  private let networkService = NetworkServices()
  
  var presenter: NewsPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeView()
    presenter = NewsPresenter(view: self, networkService: networkService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getNews(filters: .post)
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
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let rawPostType = items[indexPath.section].type,
          let postType = PhotoFilters(rawValue: rawPostType) else { return UITableViewCell() }    
    if (indexPath.row == 0) {
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
      guard let source = items[indexPath.section].sourceID else { return UITableViewCell() }
      configureHeader(cell: cell, source: source, indexPath: indexPath, filter: postType)
      return cell
    } else {
      if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
        configureText(cell: cell, indexPath: indexPath, filter: postType)
        return cell
      } else {
        if indexPath.row == 2 {
          let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
          configurePhoto(cell: cell, indexPath: indexPath, filter: postType)
          return cell
        } else {
          if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsUtilityCell", for: indexPath) as! NewsUtilityCell
            cell.delegate = self
            configureUtility(cell: cell, indexPath: indexPath, filter: postType)
            return cell
          } else {
            if indexPath.row == 4 {
              let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSeparatorCell", for: indexPath) as! NewsSeparatorCell
              return cell
            } else {
              return UITableViewCell()
            }
          }
        }
      }
    }
  }
}

extension NewsTableViewController: NewsProtocol {
  func success() {
    DispatchQueue.global().async {
      guard let items = self.presenter.items,
            let profiles = self.presenter.profiles,
            let groups = self.presenter.groups else { return }
      self.items = items
      self.profiles = profiles
      self.groups = groups
      DispatchQueue.main.async {
      self.tableView.reloadData()
      }
    }
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
