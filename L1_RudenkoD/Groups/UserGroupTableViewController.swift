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
  private var groups = [GroupsModel]()
  private let getGroupsRequest = APIService()
  private let databaseService = DatabaseServiceImpl()
  private let ref = Database.database().reference(withPath: "user")
  private var groupsFB = [FBGroupModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    
    
    
    self.ref.child(Session.shared.selfId).child("groups").observe(.value, with: { snapshot in
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getGroupsRequest.getUserGroups() { [weak self] groups in
      for item in groups {
        self?.databaseService.save(object: item, update: true)
      }
      guard let item = self?.databaseService.read(object: GroupsModel(), tableView: self?.tableView) else { return }
      self?.groups.append(contentsOf: item)
      
      for item in groups {
        let fbGroups = FBGroupModel(descr: item.descr, groups: item.name, photo: item.photo50).toAnyObject()
        self?.ref.child(Session.shared.selfId).child("groups").child(String(item.id)).setValue(fbGroups)
      }
      
      self?.tableView.reloadData()
    }
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
    let string = URL(string: groupsFB[indexPath.row].photo)!
    let avatar =  asyncPhoto(cellImage: cell.groupAvatar, url: string)
    let descr = groupsFB[indexPath.row].descr
    cell.configure(name: name, image: avatar, descr: descr)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let group = groupsFB[indexPath.row]
      group.ref?.removeValue()
    }
  }
}
