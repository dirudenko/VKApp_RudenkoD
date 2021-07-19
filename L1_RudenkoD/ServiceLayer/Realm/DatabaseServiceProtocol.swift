//
//  DatabaseService.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 07.06.2021.
//

import UIKit
import RealmSwift


protocol DatabaseServiceProtocol: AnyObject {
  func save<T: Object>(object: T, update: Bool)
  func read<T: Object>(object: T, tableView: UITableView?, collectionView: UICollectionView?) -> Results<T>?
  func delete<T: Object>(object: T)
  func deleteAll()
}

class DatabaseServiceImpl: DatabaseServiceProtocol {
  
  let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
  
  lazy var mainRealm = try! Realm(configuration: config)
  var token: NotificationToken?
  
  func save<T: Object>(object: T, update: Bool) {
    try! mainRealm.write{
      if update {
        mainRealm.add(object, update: .modified)
      } else {
        mainRealm.add(object)
      }
    }
    //print(mainRealm.configuration.fileURL)
  }
  
  func read<T: Object>(object: T, tableView: UITableView? = nil, collectionView: UICollectionView? = nil) -> Results<T>? {
    let model = mainRealm.objects(T.self)
    if tableView != nil {
      token = model.observe(on: DispatchQueue.main, { changes in
        guard let tableView = tableView else { return }
        switch changes {
        case .initial:
          tableView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
          tableView.beginUpdates()
          tableView.insertRows(at: insertions.map { IndexPath(row: $0,section: 0) }, with: .automatic)
          tableView.deleteRows(at: deletions.map { IndexPath(row: $0,section: 0) },with: .automatic)
          tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
          tableView.endUpdates()
          break
        case .error(let error):
          print("error", error.localizedDescription)
       }
      })
    }
    
    if collectionView != nil {
      token = model.observe(on: DispatchQueue.main, { changes in
        guard let collectionView = collectionView else { return }
        switch changes {
        case .initial:
          collectionView.reloadData()
        case .update(_, let deletions, let insertions, let modifications):
          collectionView.performBatchUpdates({
          collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
          collectionView.deleteItems(at: deletions.map({IndexPath(row: $0, section: 0)}))
          collectionView.reloadItems(at: modifications.map({IndexPath(row: $0, section: 0) })) }, completion: {_ in })
          //collectionView.reloadData()
        case .error(let error):
          print("error", error.localizedDescription)
        }
      }
    )}
      return model
    }
    
    func delete<T: Object>(object: T) {
      try! mainRealm.write {
        mainRealm.delete(object)
      }
    }
    func deleteAll() {
      try! mainRealm.write{
        mainRealm.deleteAll()
      }
    }
  }


