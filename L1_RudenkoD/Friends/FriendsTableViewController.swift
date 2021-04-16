//
//  FriendsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
  
  @IBOutlet var friendsTableView: UITableView!
  
  var friendIndex: Int?
  
  let nibIdentifier = "FriendTableViewCell"
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    friendsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
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
      controller.index.self = friendIndex
    }
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


