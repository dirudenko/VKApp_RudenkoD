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
  var isAnimated = false
  
  @IBOutlet weak var glassButton: UIButton!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.alpha = 0
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    searchBar.delegate = self
    for item in DataStorage.shared.allGroup{
      filteredNames.append(item.name)
      filteredAvatars.append(item.groupImage ??  UIImage())
      filteredDescription.append(item.description ?? "")
      data.append(item.name)
    }
    tableView.reloadData()
    searchBar.showsCancelButton = true
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    //self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    tableView.reloadData()
  }
  // MARK: - Table view data source
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if isSearch == false {
      return DataStorage.shared.allGroup.count
    } else {
      return  filteredNames.count
    }
  }
  
  @IBAction func pressGlassButton(_ sender: Any) {
    glassButton.findButtonAnimation( searchBar: searchBar, isAnimated: isAnimated)
    isAnimated = !isAnimated
    isSearch = !isSearch
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
  
  @objc func dismissKeyboard() {
      //Causes the view (or one of its embedded text fields) to resign the first responder status.
      view.endEditing(true)
    isAnimated = true
    isSearch = true
    glassButton.findButtonAnimation( searchBar: searchBar, isAnimated: isAnimated)
    isAnimated = !isAnimated
    isSearch = !isSearch
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if isSearch == false {
    let group = DataStorage.shared.allGroup[indexPath.row]
    if !DataStorage.shared.myGroup.contains(group) {
      DataStorage.shared.myGroup.append(group)
      self.navigationController?.popViewController(animated: true)
    } else {
      showAlert(title: "????????????", message: "???? ?????? ???????????????? ?? ???????? ????????????")
    }
    }
    else {
      let index = searchGroup()
      let group = DataStorage.shared.allGroup[index]
      if !DataStorage.shared.myGroup.contains(group) {
        DataStorage.shared.myGroup.append(group)
        self.navigationController?.popViewController(animated: true)
      } else {
        showAlert(title: "????????????", message: "???? ?????? ???????????????? ?? ???????? ????????????")
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
    if searchText.isEmpty {
      glassButton.findButtonAnimation( searchBar: searchBar, isAnimated: isAnimated)
      isAnimated = !isAnimated
      isSearch = false
      tableView.reloadData()
    } else {
      filteredNames = searchText.isEmpty  ? data : data.filter { (item: String) -> Bool in
        isSearch = true
        return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
      }
      tableView.reloadData()
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //isSearch = true
    //isAnimated = true
    glassButton.findButtonAnimation( searchBar: searchBar, isAnimated: isAnimated)
    searchBar.text = ""
    isAnimated = !isAnimated
    isSearch = !isSearch
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
}



