//
//  UserGroupTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit
import FirebaseDatabase

class UserGroupTableViewController: UITableViewController {
  
  let nibIdentifier = "GroupTableViewCell"
  private let networkService = NetworkServices()
  private let databaseService = DatabaseServiceImpl()
  private var groupsFB = [FBGroupModel]()
  
  var presenter: GroupPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    presenter = GroupPresenter(view: self, networkService: networkService, databaseService: databaseService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getGroup(tableView: self.tableView)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  groupsFB.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    let name = groupsFB[indexPath.row].groups
    let url = URL(string: groupsFB[indexPath.row].photo)!
    let descr = groupsFB[indexPath.row].descr
    cell.configure(name: name, url: url, descr: descr)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let group = groupsFB[indexPath.row]
      group.ref?.removeValue()
    }
  }
}

extension UserGroupTableViewController: GroupProtocol {
  func success() {
     let ref = Database.database().reference(withPath: "user")
    ref.child(Session.shared.selfId).child("groups").observe(.value, with: { snapshot in
        var newGroupFB: [FBGroupModel] = []
  for child in snapshot.children {
    if let snapshot = child as? DataSnapshot,
       let group = FBGroupModel(snapshot: snapshot) {
      newGroupFB.append(group)
            }
        }
        self.groupsFB = newGroupFB
        self.tableView.reloadData()
    })
  }
  
  
}
