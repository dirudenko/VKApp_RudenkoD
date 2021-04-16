//
//  Group.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import Foundation
import UIKit

struct Group {
  var name: String
  var description: String?
  var groupImage: UIImage?
  var isMember: Bool = false
}

extension Group: Equatable {
  static func == (lhs: Group, rhs: Group) -> Bool {
          return
              lhs.name == rhs.name
  }
}
      
