//
//  AllGroupsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
  
  @IBOutlet var allGroupsTableView: UITableView!
  
  let nibIdentifier = "GroupTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //tableView.reloadData()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    allGroupsTableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    //self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return  DataStorage.shared.allGroup.count
  }
    
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    let name = DataStorage.shared.allGroup[indexPath.row].name
    let image = DataStorage.shared.allGroup[indexPath.row].groupImage ?? UIImage()
    let descr = DataStorage.shared.allGroup[indexPath.row].description
    for item in DataStorage.shared.myGroup {
      if item.name == name
      { cell.groupMember.image = UIImage(named: "kiss") }
    }
    cell.configure(name: name, image: image, descr: descr)
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let group = DataStorage.shared.allGroup[indexPath.row]
    if !DataStorage.shared.myGroup.contains(group) {
      DataStorage.shared.myGroup.append(group)
      self.navigationController?.popViewController(animated: true)
    } else {
      showAlert(title: "Ошибка", message: "Вы уже состоите в этой группе")
    }
  }
  
  func showAlert(title: String, message: String?) {
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(action)
    present(alert, animated: true, completion: {})
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  // Override to support editing the table view.
  //     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  //     if editingStyle == .insert {
  //      DataStorage.shared.allGroup[indexPath.row].status = true
  //
  //     // Delete the row from the data source
  //     //tableView.deleteRows(at: [indexPath], with: .fade)
  //     }
  //     }
  
  
  
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


