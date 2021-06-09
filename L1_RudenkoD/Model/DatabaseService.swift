//
//  DatabaseService.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 07.06.2021.
//

import Foundation
import RealmSwift


protocol DatabaseService {
  func save<T: Object>(object: T, update: Bool)
  func read<T: Object>(object: T) -> Results<T>?
  func delete<T: Object>(object: T)
  func deleteUsers()
  
}

class DatabaseServiceImpl: DatabaseService {
  
  let config = Realm.Configuration( schemaVersion: 7, migrationBlock: { migration, oldSchemaVersion in
    print("oldSchemaVersion: \(oldSchemaVersion)")
    if (oldSchemaVersion < 7) {
      print("  performing migration")
      var nextID = 0
      migration.enumerateObjects(ofType: PhotosModel.className()) { oldItem, newItem in
        newItem!["id"] = nextID
        nextID += 1
      }
    }
  })
  
  lazy var mainRealm = try! Realm(configuration: config)
  
  func save<T: Object>(object: T, update: Bool) {
    try! mainRealm.write{
      if update {
        mainRealm.add(object, update: .modified)
      } else {
        mainRealm.add(object)
      }
    }
  }
  
  func read<T: Object>(object: T) -> Results<T>? {
    return mainRealm.objects(T.self)
  }
  
  func delete<T: Object>(object: T) {
    try! mainRealm.write {
      mainRealm.delete(object)
    }
  }
  
  func deleteUser(user: UserModel) {
    try! mainRealm.write{
      mainRealm.delete(user)
    }
  }
  
  func deleteUsers() {
    try! mainRealm.write{
      mainRealm.deleteAll()
    }
  }
}
