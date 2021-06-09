//
//  UserGroupTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class UserGroupTableViewController: UITableViewController {
  
  let nibIdentifier = "GroupTableViewCell"
  private var groups = [GroupsModel]()
  private let getGroupsRequest = APIService()
  private let databaseService = DatabaseServiceImpl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getGroupsRequest.getUserGroups() { [weak self] groups in
      
      for item in groups {
        self?.databaseService.save(object: item, update: true)
      }
      guard let item = self?.databaseService.read(object: GroupsModel()) else { return }
      self?.groups.append(contentsOf: item)
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
    let string = URL(string: groups[indexPath.row].photo50)!
    let avatar =  asyncPhoto(cellImage: cell.groupAvatar, url: string)
    let descr = groups[indexPath.row].descr
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
