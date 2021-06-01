//
//  UserGroupTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class UserGroupTableViewController: UITableViewController {
  
  let nibIdentifier = "GroupTableViewCell"
  private var groups = [Groups]()
  private let getGroupsRequest = ApiRequests()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getGroupsRequest.getUserGroups() { [weak self] groups in
      self?.groups = groups
      self?.tableView.reloadData()
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  groups.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    let name = groups[indexPath.row].name
    var avatar =  UIImage()
    let string = groups[indexPath.row].photo50
    if let image = getImage(from: string) {
      avatar = image
    }
    let descr = groups[indexPath.row].description
    cell.configure(name: name, image: avatar, descr: descr)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      DataStorage.shared.myGroup.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}
