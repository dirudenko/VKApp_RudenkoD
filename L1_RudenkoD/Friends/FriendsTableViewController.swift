//
//  FriendsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
  
  @IBOutlet var buttons: [UIButton]!
  
  private var friendIndex: Int?
  var charIndex = [String]()
  let nibIdentifier = "FriendTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    charIndex = findChars()
    print(charIndex)
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return DataStorage.shared.usersArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
    let name = DataStorage.shared.usersArray[indexPath.row].name
    let image = DataStorage.shared.usersArray[indexPath.row].avatar ?? UIImage()
    
    cell.configure(name: name, image: image)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      DataStorage.shared.usersArray.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    friendIndex = indexPath.row
    performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      controller.row.self = friendIndex
    }
  }
}


extension FriendsTableViewController {
  func findChars() -> [String] {
    var unsortedChars = Set<String>()
    for item in DataStorage.shared.usersArray {
      let char = item.name.first
      unsortedChars.insert(String(char!))
    }
    let sortedChars = Array(unsortedChars.sorted())
    return Array(sortedChars)
  }
}

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

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

extension FriendsTableViewController {
  func makeButtonWithText(text:String) -> UIButton {
    let myButton = UIButton(type: UIButton.ButtonType.system)
    myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
    myButton.backgroundColor = UIColor.blue
    myButton.setTitle(text, for: .normal)
    myButton.setTitleColor(UIColor.white, for: .normal)
    return myButton
  }
}

