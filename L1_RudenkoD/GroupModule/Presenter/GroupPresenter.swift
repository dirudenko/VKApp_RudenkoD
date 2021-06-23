//
//  GroupPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 23.06.2021.
//

import UIKit
import RealmSwift
import FirebaseDatabase

protocol GroupProtocol: AnyObject {
  func success()
}

protocol GroupPresenterProtocol: AnyObject {
  init(view: GroupProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol)
  func getGroup(tableView: UITableView)
  var group: Results<GroupsModel>? {get set}
}

class GroupPresenter: GroupPresenterProtocol {
 
  var group: Results<GroupsModel>?
  let view: GroupProtocol
  let ref = Database.database().reference(withPath: "user")
  
  weak var networkService: NetworkServicesProtocol!
  weak var databaseService: DatabaseServiceProtocol!
  
  required init(view: GroupProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol) {
    self.view = view
    self.networkService = networkService
    self.databaseService = databaseService
  }
  
  func getGroup(tableView: UITableView) {
    networkService.getUserGroups() { [weak self] groups in
      guard let self = self else { return }
      for item in groups {
        self.databaseService.save(object: item, update: true)
      }
      self.group = self.databaseService.read(object: GroupsModel(), tableView: tableView, collectionView: nil)
      guard let group = self.group else { return }
      for item in group {
        let fbGroups = FBGroupModel(descr: item.descr, groups: item.name, photo: item.photo50).toAnyObject()
        self.ref.child(Session.shared.selfId).child("groups").child(String(item.id)).setValue(fbGroups)
      }
      self.view.success()
    }
  }
}

