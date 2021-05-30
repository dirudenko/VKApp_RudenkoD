//
//  UserGroupTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit
import Alamofire

class UserGroupTableViewController: UITableViewController {
  
  let nibIdentifier = "GroupTableViewCell"
  private var groups = [Groups]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getInfo(method: "groups.get") { [weak self] groups in
      self?.groups = groups
      }
    
    
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return  groups.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! GroupTableViewCell
    let name = groups[indexPath.row].name
    //let image = DataStorage.shared.myGroup[indexPath.row].groupImage ?? UIImage()
    var avatar =  UIImage()
    let string = groups[indexPath.row].photo50
    if let image = getImage(from: string) {
      avatar = image
    }
    let descr = groups[indexPath.row].description
    cell.configure(name: name, image: avatar, descr: descr)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      DataStorage.shared.myGroup.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}

extension UserGroupTableViewController {
  
  func getInfo(method: String, completion: @escaping ([Groups]) -> Void){
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "extended": 1,
      "fields": "name,status",
      "access_token": token,
      "v": "5.131"]
    let path = method
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      //  print(data.prettyJSON!)
      let groups = try! JSONDecoder().decode(GroupsResponse.self, from: data).response.items
      completion(groups)
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }
}
