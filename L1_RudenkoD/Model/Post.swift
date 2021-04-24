//
//  Post.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import Foundation
import UIKit

struct Post {
  var createdBy: User
  var caption: String
  var numberOfLikes: Int
  var numberOfComments: Int
  var numberOfShares: Int
  var numberOfViews: Int
  var image1: UIImage?
  var image2: UIImage?
}
