//
//  NewsTableViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  private let nibIdentifier = "NewsTableViewCell"
  private var news = [Post]()
  private var friendIndex: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
    self.tableView.register(nibFile, forCellReuseIdentifier: nibIdentifier)
    news = DataStorage.shared.postedNews
    self.tableView.rowHeight = UITableView.automaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
   
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return news.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: nibIdentifier, for: indexPath) as! NewsTableViewCell
    let image = news[indexPath.row].createdBy.avatar
    let name = news[indexPath.row].createdBy.name
    let posted = generateDay()
    let newNews = news[indexPath.row].caption
    let imageNews1 = news[indexPath.row].image1
    let numberOfLikes = news[indexPath.row].numberOfLikes
    let shared = String(news[indexPath.row].numberOfShares)
    let views = String("\(news[indexPath.row].numberOfViews)K")
    let comments = String(news[indexPath.row].numberOfComments)
    cell.userImage.shadow(anyImage: image!, anyView: cell.viewForShadow)
    cell.configure(image: image, name: name, posted: posted, newNews: newNews, imageNews1: imageNews1, shared: shared, view: views, comments: comments)
    cell.likeCounter.text = String(numberOfLikes)
    cell.delegate = self
    
    return cell
  }
  func generateDay() -> String? {
    let date = Date()
    let calendar = Calendar.current
    var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    guard
      let days = calendar.range(of: .day, in: .month, for: date),
      let randomDay = days.randomElement()
    else {
      return nil
    }
    dateComponents.setValue(randomDay, for: .day)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YY"
    let tmp = calendar.date(from: dateComponents)
    return dateFormatter.string(from: tmp!)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "friendFromNews" {
      let controller = segue.destination as! DetailedFriendCollectionViewController
      controller.index.self = friendIndex
    }
    
    
  }
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

extension NewsTableViewController: NewsButtonsDelegate {
  func namePressed(button: UIButton) {
    let name = button.titleLabel!.text
    var users = [String]()
    for item in DataStorage.shared.usersArray {
      users.append(item.name)
    }
    var i = 0
    for item in users {
      if item == name {
        friendIndex = i
      } else {
        i += 1
      }
    }
    performSegue(withIdentifier: "friendFromNews", sender: self)
  }
  
  func share() {
    let text = "Смотри какой интересный текст"
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook ]
    self.present(activityViewController, animated: true, completion: nil)
  }
}
