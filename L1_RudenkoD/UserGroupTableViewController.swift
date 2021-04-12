//
//  UserGroupTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class UserGroupTableViewController: UITableViewController {
  
  @IBOutlet var myGroupTableView: UITableView!
  
  let nibIdentifier = "GroupTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    myGroupTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return  DataStorage.shared.myGroup.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    let name = DataStorage.shared.myGroup[indexPath.row].name
    let image = DataStorage.shared.myGroup[indexPath.row].groupImage ?? UIImage()
    let descr = DataStorage.shared.myGroup[indexPath.row].description
    cell.configure(name: name, image: image, descr: descr)
    return cell
  }

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      DataStorage.shared.myGroup.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      DataStorage.shared.allGroup[indexPath.row].status = false
    }
  }
  
  /*
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "info" {
      let friend = segue.destination as! DetailedFriendCollectionViewController
      let indexPath = sender as! IndexPath
      let friend1 = DataStorage.shared.usersArray[indexPath.row]
      friend.friendInfo = friend1
    }
  }
  */
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
  
}
