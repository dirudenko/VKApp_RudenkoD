//
//  FullImageCustomSegue.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.05.2021.
//

import UIKit


class FullImageCustomSegue: UIStoryboardSegue {
  
  
  override func perform() {
    let src = self.source as! PhotosCollectionViewController
    let index = src.indexPhoto!
   // let image = src.photoArray[index]
    let dst = self.destination as! AnimatedPhotosViewController
    
   // dst.primaryImageView = src.photoArray[indexPhoto]
   // dst.fullImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//    UIView.animate(withDuration: 0.1,
//                   delay: 0,
//                //   options:
//                   animations: {
//                    //src.primaryImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//                  },
//                   completion: {_ in
                    UIView.animate(withDuration: 0.3,
                                   delay: 0.5,
                                  // options: <#T##UIView.AnimationOptions#>,
                                   animations: {
                                   // dst.fullImage.transform = CGAffineTransform(scaleX: 2, y: 2)
                                   },
                                   completion: {_ in
                                    //src.navigationController?.pushViewController(dst, animated: false)
                                    //super.perform()
                                    src.present(dst, animated: false, completion: nil)
                                   
                                    
                                    
                                   })
                    
                   }
    
   
    
  }

//}
