//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit

class FriendsListViewController: UIViewController {
  
  private struct Section {
    let char : String
    var user : [UsersModel]
  }
  
  @IBOutlet weak var friendsTableView: UITableView!
 
  private var chosenFriend = (section: 0, row: 0)
  private let nibIdentifier = "FriendTableViewCell"
  private var users = [UsersModel]()
  private var sections = [Section]()

  private let getFriendsRequest = APIService()
  private let databaseService = DatabaseServiceImpl()

 
  override func viewDidLoad() {
    super.viewDidLoad()
   // databaseService.deleteUsers()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard users.isEmpty else { return }
    getFriendsRequest.getFriendList(userId: nil) { [weak self] users in
      for item in users {
        self?.databaseService.save(object: item, update: true)
      }
      guard let item = self?.databaseService.read(object: UsersModel()) else { return }
      self?.users.append(contentsOf: item)
      
      let usersDictionary = Dictionary(grouping: self!.users,
                                       by: { $0.name.first! })
        .sorted(by: { $0.key < $1.key })
        .map({ (char:$0.key, User:$0.value)})
      for (key, value) in usersDictionary {
        self?.sections.append(Section(char: String(key), user: value))
        self?.friendsTableView.reloadData()
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let id = sections[chosenFriend.section].user[chosenFriend.row].id
      Session.shared.userId.append(id)
    }
  }
}

// MARK: - Table view data source

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    let section = sections[indexPath.section]
    let username = section.user[indexPath.row]
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
    return sections[section].user.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return sections.map{$0.char}
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].char
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    view.tintColor = UIColor.systemGray2
    let header = view as! UITableViewHeaderFooterView
    header.textLabel?.textColor = UIColor.systemBlue
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let indexSet = IndexSet(arrayLiteral: indexPath.section)
      sections[indexPath.section].user.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      if sections[indexPath.section].user.count == 0 {
        sections.remove(at: indexPath.section)
        tableView.beginUpdates()
        tableView.deleteSections(indexSet, with: .automatic)
        tableView.endUpdates()
      }
    }
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chosenFriend.row = indexPath.row
    chosenFriend.section = indexPath.section
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}








