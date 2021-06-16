//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit
import FirebaseDatabase

class FriendsListViewController: UIViewController {
  
  @IBOutlet weak var friendsTableView: UITableView!
 
  private var row = Int()
  private let nibIdentifier = "FriendTableViewCell"
  private var users = [UsersModel]()

  private let getFriendsRequest = APIService()
  private let databaseService = DatabaseServiceImpl()
  private let ref = Database.database().reference(withPath: "user")
  private var usersFB = [FBUserModel]()

 
  override func viewDidLoad() {
    super.viewDidLoad()
    //databaseService.deleteAll()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    self.ref.child(Session.shared.selfId).child("friends").observe(.value, with: { snapshot in
            var newUsersFB: [FBUserModel] = []
      for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let user = FBUserModel(snapshot: snapshot) {
          newUsersFB.append(user)
                }
            }
            self.usersFB = newUsersFB
            self.friendsTableView.reloadData()
        })
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupScreen()
  }
  
  func setupScreen() {
    guard users.isEmpty else { return }
    getFriendsRequest.getFriendList(userId: nil) { [weak self] users in
      guard let self = self else { return }
      for item in users {
        self.databaseService.save(object: item, update: true)
      }
      guard let item = self.databaseService.read(object: UsersModel(), tableView: self.friendsTableView) else { return }
      self.users.append(contentsOf: item)
      
      for item in users {
        let fbUsers = FBUserModel(lastName: item.lastName, photo50: item.photo50, firstName: item.firstName, online: item.online).toAnyObject()
        self.ref.child(Session.shared.selfId).child("friends").child(String(item.id)).setValue(fbUsers)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let id = users[row].id
      Session.shared.userId.append(id)
    }
  }
}

// MARK: - Table view data source

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
   
    let username =  usersFB[indexPath.row]
    let string = URL(string: username.photo50)!
    let avatar = asyncPhoto(cellImage: cell.avatarImage, url: string)
    if username.online == 1 {
      cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.green.cgColor)
    } else {
      cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    }
    cell.configure(name: username.name, image: avatar)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usersFB.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    view.tintColor = UIColor.systemGray2
    let header = view as! UITableViewHeaderFooterView
    header.textLabel?.textColor = UIColor.systemBlue
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let user = usersFB[indexPath.row]
      user.ref?.removeValue()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    row = indexPath.row
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}








