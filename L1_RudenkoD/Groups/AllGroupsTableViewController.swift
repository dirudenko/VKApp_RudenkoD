//
//  AllGroupsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  let nibIdentifier = "GroupTableViewCell"
  private var filteredNames = [String]()
  private var filteredDescription = [String]()
  private var filteredAvatars = [UIImage]()
  private var data = [String]()
  private var isSearch = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //tableView.reloadData()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    searchBar.delegate = self
    for item in DataStorage.shared.allGroup{
      filteredNames.append(item.name)
      filteredAvatars.append(item.groupImage ??  UIImage())
      filteredDescription.append(item.description ?? "")
      data.append(item.name)
    }
  
    //searchBar.showsCancelButton = true
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
    return  filteredNames.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    if isSearch == false {
      let name = DataStorage.shared.allGroup[indexPath.row].name
      let image = DataStorage.shared.allGroup[indexPath.row].groupImage ?? UIImage()
      let descr = DataStorage.shared.allGroup[indexPath.row].description
      for item in DataStorage.shared.myGroup {
        if item.name == name
        { cell.groupMember.image = UIImage(systemName: "checkmark") }
      }
      cell.configure(name: name, image: image, descr: descr)
    
    }
    else {
      let name = filteredNames[indexPath.row]
      for item in DataStorage.shared.myGroup {
        if item.name == name
        { cell.groupMember.image = UIImage(systemName: "checkmark") }
      }
      cell.configure(name: name, image: nil, descr: nil)
    }
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if isSearch == false {
    let group = DataStorage.shared.allGroup[indexPath.row]
    if !DataStorage.shared.myGroup.contains(group) {
      DataStorage.shared.myGroup.append(group)
      self.navigationController?.popViewController(animated: true)
    } else {
      showAlert(title: "Ошибка", message: "Вы уже состоите в этой группе")
    }
    }
    else {
      let index = searchGroup()
      let group = DataStorage.shared.allGroup[index]
      if !DataStorage.shared.myGroup.contains(group) {
        DataStorage.shared.myGroup.append(group)
        self.navigationController?.popViewController(animated: true)
      } else {
        showAlert(title: "Ошибка", message: "Вы уже состоите в этой группе")
      }
    }
  }
  
  func showAlert(title: String, message: String?) {
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(action)
    present(alert, animated: true, completion: {})
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty { isSearch = false}
    filteredNames = searchText.isEmpty  ? data : data.filter { (item: String) -> Bool in
      isSearch = true
      return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
    tableView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearch = false
    tableView.reloadData()
  }
  
  func searchGroup() -> Int {
    var groupsname = [String]()
    for item in DataStorage.shared.allGroup {
      groupsname.append(item.name)
    }
    let tmp = groupsname.filter () { filteredNames.contains($0) }
    return groupsname.firstIndex(of: tmp[0])!
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


