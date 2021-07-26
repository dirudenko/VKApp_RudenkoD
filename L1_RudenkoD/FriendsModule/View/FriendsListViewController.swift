//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit

class FriendsListViewController: UIViewController {
  @IBOutlet weak var friendsTableView: UITableView!
 
  private var row = Int()
  private let nibIdentifier = "FriendTableViewCell"
  private let databaseService = DatabaseServiceImpl()
  var presenter: FriendsPresenterProtocol!

 
  override func viewDidLoad() {
    super.viewDidLoad()
   // databaseService.deleteAll()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    
    presenter = FriendsPresenter(view: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getFriends()
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      guard  let id = presenter.friends?[row].id else { return }
      Session.shared.userId.append(id)
    }
  }
}

// MARK: - Table view data source

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    
    guard  let username = presenter.friends?[indexPath.row] else { return UITableViewCell() }
    let url = URL(string: username.photo50)!
    let avatar = UIImage()
    if username.online == 1 {
     cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.green.cgColor)
    } else {
      cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    }
    cell.configure(name: username.name, url: url)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.friends?.count ?? 0
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
      guard let user = presenter.friends?[indexPath.row] else { return }
           self.databaseService.delete(object: user)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    row = indexPath.row
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}

extension FriendsListViewController: FriendsProtocol {
  func success() {
    friendsTableView.reloadData()
  }
}









