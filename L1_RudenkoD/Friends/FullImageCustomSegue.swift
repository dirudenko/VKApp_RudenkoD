//
//  FullImageCustomSegue.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.05.2021.
//

import UIKit

class FullImageCustomSegue: UIStoryboardSegue {
  
  
  override func perform() {
    let src = self.source as! AnimatedPhotosViewController
    let dst = self.destination as! FullImageViewController
    dst.fullImage = src.primaryImageView
   // dst.fullImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//    UIView.animate(withDuration: 0.1,
//                   delay: 0,
//                //   options:
//                   animations: {
//                    //src.primaryImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//                    src.primaryImageView.alpha = 0
//                  },
//                   completion: {_ in
                    UIView.animate(withDuration: 0.3,
                                   delay: 0.5,
                                  // options: <#T##UIView.AnimationOptions#>,
                                   animations: {
                                   // dst.fullImage.transform = CGAffineTransform(scaleX: 2, y: 2)
                                   },
                                   completion: {_ in
                                   // src.navigationController?.pushViewController(dst, animated: false)
                                    //super.perform()
                                    src.present(dst, animated: false, completion: nil)
                                    //dst.fullImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                   // src.primaryImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    
                                   })
                    
                   }
    
   
    
  }

//}
