//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
  private var friendRow: Int?
  private var friendSection: Int?
  private let nibIdentifier = "FriendTableViewCell"
  private var users = [Users]()
  
  private struct Section {
    let char : String
    var user : [Users]
  }
  
  private var sections = [Section]()
  @IBOutlet weak var friendsTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getInfo(method: "friends.get") { [weak self] users in
      self?.users = users
      let usersDictionary = Dictionary(grouping: self!.users,
                                       by: { $0.name.first! })
        .sorted(by: { $0.key < $1.key })
        .map({ (char:$0.key, User:$0.value)})
      for (key, value) in usersDictionary {
        self?.sections.append(Section(char: String(key), user: value))
      }
    }
    
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    //self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      guard let friendSection = friendSection,
            let friendRow = friendRow else {return}
      controller.friendId = sections[friendSection].user[friendRow].id
    }
  }
}

// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    let section = sections[indexPath.section]
    let username = section.user[indexPath.row]
    var avatar =  UIImage()
    let string = username.photo50
    if let image = getImage(from: string) {
      avatar = image
    }
    cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
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
    friendRow = indexPath.row
    friendSection = indexPath.section
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}


extension FriendsViewController {
  func getInfo(method: String, completion: @escaping ([Users]) -> Void){
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "fields": "nickname,photo_50",
      "access_token": token,
      "v": "5.131"]
    let path = method
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      let users = try! JSONDecoder().decode(FriendsResponse.self, from: data).response.items
      completion(users)
      DispatchQueue.main.async { [weak self] in
        self?.friendsTableView.reloadData()
      }
    }
  }
}







