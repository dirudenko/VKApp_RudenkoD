//
//  AnimatedPhotosViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 28.04.2021.
//

import UIKit
import Alamofire

class AnimatedPhotosViewController: UIViewController {
  
  @IBOutlet weak var primaryImageView: UIImageView!
  @IBOutlet weak var secondaryImageView: UIImageView!
 // @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var viewForAnimation: UIView!
  
  private var interactiveAnimator: UIViewPropertyAnimator!
  private var isLeftSwipe = false
  private var isRightSwipe = false
  private var chooseFlag = false
  private var currentIndex = Int()
  private var isLiked = true
  private var images = [UIImage]()
  private var viewTranslation = CGPoint(x: 0, y: 0)
  var friendId = Session.shared.userId.last
  var indexPhoto: Int?
  private var urlArray = [String]()
  private let getUserRequest = ApiRequests()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
   // viewLoadSetup()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //navigationController?.setNavigationBarHidden(true, animated: animated)
    
    getUserRequest.getPhoto(id: friendId!) {  [weak self] photos in
      let albumArray = photos
      albumArray.forEach {
        $0.sizes.forEach {
          if $0.type == "m"  {
            self?.urlArray.append($0.url)
          }
        }
      }
        self?.urlArray.forEach {
       // var avatar =  UIImage()
          let string = $0
          if let image = self?.getImage(from: string) {
          self?.images.append(image)
        }
        }
        self?.setImages(images: self!.images)
        self?.setup()
      }
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
   // navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  private func viewLoadSetup() {
    //guard let indexUser = friendId else { return }
    
//    var image = [UIImage]()
//    let string = urlArray
//    string.forEach{
//      if let urlImage = getImage(from: $0) {
//        image.append(urlImage)
//      }
//    }
    
    //images = image
    
  }
    
  func setImages(images: [UIImage]) {
    self.images = images
    if self.images.count > 0 {
      primaryImageView.image = images[indexPhoto ?? 0]
    }
   // pageControl.numberOfPages = images.count
  }
  
  func setup() {
    self.primaryImageView.isUserInteractionEnabled = true
    let swipe = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
    let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    primaryImageView.addGestureRecognizer(recognizer)
    viewForAnimation.addGestureRecognizer(swipe)
    
    primaryImageView.frame = viewForAnimation.bounds
    secondaryImageView.frame = viewForAnimation.bounds
    primaryImageView.contentMode = .scaleAspectFill
    secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
    
//    pageControl.backgroundColor = UIColor.clear
//    pageControl.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
//    pageControl.numberOfPages = images.count
//    pageControl.currentPage = indexPhoto ?? 0
//    pageControl.pageIndicatorTintColor = UIColor.lightGray
//    pageControl.currentPageIndicatorTintColor = UIColor.systemBlue
  //  viewForAnimation.bringSubviewToFront(pageControl)
  }
}
extension AnimatedPhotosViewController {
  
//  @IBAction func pressPageControl(_ sender: UIPageControl) {
//    currentIndex = sender.currentPage
//    self.primaryImageView.transform = .identity
//    self.primaryImageView.image = images[currentIndex]
//    self.secondaryImageView.transform = .identity
//  }
  
  @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
    if let animator = interactiveAnimator,
       animator.isRunning {
      return
    }
    currentIndex = indexPhoto ?? 0
    switch recognizer.state {
    case .began:
      self.primaryImageView.transform = .identity
      self.primaryImageView.image = images[currentIndex]
      self.secondaryImageView.transform = .identity
      interactiveAnimator?.startAnimation()
      interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut,
                                                   animations: { [weak self] in
                                                    self?.primaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                                                   })
      interactiveAnimator.pauseAnimation()
      isLeftSwipe = false
      isRightSwipe = false
      chooseFlag = false
    case .changed:
      var translation = recognizer.translation(in: self.view)
      if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
        if self.currentIndex == (images.count - 1) {
          interactiveAnimator.stopAnimation(true)
          return
        }
        chooseFlag = true
        onChange(isLeft: true)
        interactiveAnimator.stopAnimation(true)
        interactiveAnimator.addAnimations { [weak self] in
          self?.primaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
          self?.secondaryImageView.transform = .identity
        }
        interactiveAnimator.addCompletion({ [weak self] _ in
          self?.onChangeCompletion(isLeft: true)
        })
        
        interactiveAnimator.startAnimation()
        interactiveAnimator.pauseAnimation()
        isLeftSwipe = true
      }
      
      if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
        if self.currentIndex == 0 {
          interactiveAnimator.stopAnimation(true)
          return
        }
        chooseFlag = true
        onChange(isLeft: false)
        interactiveAnimator.stopAnimation(true)
        interactiveAnimator.addAnimations { [weak self] in
          self?.primaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
          self?.secondaryImageView.transform = .identity
          // self?.secondaryImageView.alpha = 1
          
        }
        interactiveAnimator.addCompletion({ [weak self] _ in
          self?.onChangeCompletion(isLeft: false)
        })
        interactiveAnimator.startAnimation()
        interactiveAnimator.pauseAnimation()
        isRightSwipe = true
      }
      
      if isRightSwipe && (translation.x < 0) {return}
      if isLeftSwipe && (translation.x > 0) {return}
      
      if translation.x < 0 {
        translation.x = -translation.x
      }
      interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
      
    case .ended:
      if let animator = interactiveAnimator,
         animator.isRunning {
        return
      }
      var translation = recognizer.translation(in: self.view)
      
      if translation.x < 0 {translation.x = -translation.x}
      
      if (translation.x / (UIScreen.main.bounds.width)) > 0.5  {
        interactiveAnimator.startAnimation()
      }
      else {
        interactiveAnimator.stopAnimation(true)
        interactiveAnimator.finishAnimation(at: .start)
        interactiveAnimator.addAnimations { [weak self] in
          self?.primaryImageView.transform = .identity
          guard let weakSelf = self else {return}
          if weakSelf.isLeftSwipe {
            self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
          }
          if weakSelf.isRightSwipe {
            self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
          }
          self?.secondaryImageView.alpha = 0
        }
        interactiveAnimator.addCompletion({ [weak self] _ in
          self?.primaryImageView.transform = .identity
          self?.secondaryImageView.transform = .identity
        })
        interactiveAnimator.startAnimation()
      }
      
    default:
      return
    }
  }
  
  private func onChange(isLeft: Bool) {
    self.primaryImageView.transform = .identity
    self.secondaryImageView.transform = .identity
    self.primaryImageView.image = images[currentIndex]
    
    if isLeft {
      self.secondaryImageView.image = images[currentIndex + 1]
      self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
      self.secondaryImageView.alpha = 1
      
    }
    else {
      self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
      self.secondaryImageView.image = images[currentIndex - 1]
      self.secondaryImageView.alpha = 1
    }
  }
  
  
  private func onChangeCompletion(isLeft: Bool) {
    self.primaryImageView.transform = .identity
    self.secondaryImageView.transform = .identity
    if isLeft {
      self.currentIndex += 1
    }
    else {
      self.currentIndex -= 1
    }
    self.primaryImageView.image = self.images[self.currentIndex]
    viewForAnimation.bringSubviewToFront(self.primaryImageView)
   // self.pageControl.currentPage = self.currentIndex
    self.indexPhoto = self.currentIndex
  }
  
  @objc func handleDismiss(sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .changed:
      viewTranslation = sender.translation(in: view)
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.7,
                     initialSpringVelocity: 1,
                     options: .curveEaseOut,
                     animations: {[weak self] in
                      self?.view.transform = CGAffineTransform(translationX: 0, y: (self?.viewTranslation.y)!)
                     })
    case .ended:
      if viewTranslation.y < 200 {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.transform = .identity
                       })
      } else {
        //self.navigationController?.popViewController(animated: false)
        dismiss(animated: false)
      }
    default:
      break
    }
  }
  
}

extension AnimatedPhotosViewController {
  func getPhoto(completion: @escaping ([Item]) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "count": 199,
      "owner_id": friendId!,
      "no_service_albums": 1,
      "access_token": token,
      "v": "5.77"]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
    //  print(data.prettyJSON!)
      let photos = try! JSONDecoder().decode(Photos.self, from: data).response.items
      completion(photos)
      DispatchQueue.main.async { [weak self] in
        var image = [UIImage]()
        let string = self?.urlArray
        string!.forEach{
          if let urlImage = self?.getImage(from: $0) {
            image.append(urlImage)
          }
        }
        self?.setImages(images: self!.images)
        self?.setup()
      }
    }
  }
}

