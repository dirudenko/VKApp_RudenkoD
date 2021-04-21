//
//  FriendsViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit

class FriendsViewController: UIViewController {
  var chosenFriend: User?
  private var friendRow: Int?
  private var friendSection: Int?
  private var charIndex: Int?
  private let nibIdentifier = "FriendTableViewCell"
  var index: Int?
  
  private struct Section {
      let char : String
      let user : [User]
  }
  
  private var sections = [Section]()
  
  @IBOutlet weak var friendsTableView: UITableView!
  
  @IBOutlet weak var charPeekerControl: CharPeekerControl!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    friendsTableView.dataSource = self
    friendsTableView.delegate = self
    charPeekerControl.delegate = self
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    //button.setTitle(String(charIndex[0]), for: .normal)
    self.view.sendSubviewToBack(charPeekerControl)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    self.navigationItem.rightBarButtonItem = self.editButtonItem
    for (key, value) in DataStorage.shared.groupedPeople {
      sections.append(Section(char: String(key), user: value))
    }
    print(type(of: sections) )
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      chosenFriend = sections[friendSection!].user[friendRow!]
      var i = 0
      for item in DataStorage.shared.usersArray {
        if item.name == chosenFriend?.name {
          index = i
        }
        i += 1
      }
      controller.index = index
    }
  }
}
// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
      let section = sections[indexPath.section]
      let username = section.user[indexPath.row]
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
    
   view.tintColor = UIColor.lightGray
      let header = view as! UITableViewHeaderFooterView
      header.textLabel?.textColor = UIColor.systemBlue
   
  }
  
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      sections.remove(at: indexPath.row)
//      tableView.beginUpdates()
//      tableView.deleteRows(at: [indexPath], with: .fade)
//      tableView.deleteSections([1], with: .fade)
//      tableView.endUpdates()
//    }
//    tableView.reloadData()
//  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    friendRow = indexPath.row
    friendSection = indexPath.section
      performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
}

extension FriendsViewController: NameDelegate {
  func didPressButton(button: UIButton) {
    let char = button.titleLabel!.text
    var names = [String]()
    var row = 0
    var userSection: Int?
    for section in sections {
      if section.char == char {
        userSection = row
      }
      row += 1
    }
        let indexPath = IndexPath(row: 0, section: userSection!)
        friendsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
    }
 








/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
