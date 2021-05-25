//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit

class FriendsViewController: UIViewController {
  private var friendRow: Int?
  private var friendSection: Int?
 // private var charIndex: Int?
  private let nibIdentifier = "FriendTableViewCell"
  var index: Int?
  
  private struct Section {
    let char : String
    var user : [User]
  }
  
  private var sections = [Section]()
  
  @IBOutlet weak var friendsTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    self.navigationItem.rightBarButtonItem = self.editButtonItem
    for (key, value) in DataStorage.shared.groupedPeople {
      sections.append(Section(char: String(key), user: value))
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      let chosenFriend = sections[friendSection!].user[friendRow!]
      controller.index = DataStorage.shared.usersArray.firstIndex(where: { $0.name == chosenFriend.name })
    }
  }
}

// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    let section = sections[indexPath.section]
    let username = section.user[indexPath.row]
    cell.avatarImage.shadow(anyImage: username.avatar!, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    cell.configure(name: username.name, image: username.avatar)
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










