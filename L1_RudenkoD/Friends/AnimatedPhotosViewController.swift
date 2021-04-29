//
//  AnimatedPhotosViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 28.04.2021.
//

import UIKit

class AnimatedPhotosViewController: UIViewController {
  
  @IBOutlet weak var primaryImageView: UIImageView!
  @IBOutlet weak var secondaryImageView: UIImageView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var viewForAnimation: UIView!
  @IBOutlet weak var likeCounter: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  
  private var interactiveAnimator: UIViewPropertyAnimator!
  private var isLeftSwipe = false
  private var isRightSwipe = false
  private var chooseFlag = false
  private var currentIndex = 0
  private var isLiked = true
  private var images = [UIImage]()
  var index: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    images = DataStorage.shared.usersArray[index!].photoArray
    setImages(images: images)
    setup()
    // Do any additional setup after loading the view.
  }
  
  func setImages(images: [UIImage]) {
    self.images = images
    if self.images.count > 0 {
      primaryImageView.image = images.first
    }
    pageControl.numberOfPages = images.count
  }
  
  func setup() {
    let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    viewForAnimation.addGestureRecognizer(recognizer)
    likeCounter.text = "0"
    primaryImageView.frame = viewForAnimation.bounds
    secondaryImageView.frame = viewForAnimation.bounds
    secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
    
    pageControl.backgroundColor = UIColor.clear
    pageControl.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
    pageControl.numberOfPages = images.count
    pageControl.currentPage = 0
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.black
    viewForAnimation.bringSubviewToFront(pageControl)
  }
  
  
  @IBAction func pressPageControl(_ sender: UIPageControl) {
    currentIndex = sender.currentPage
    self.primaryImageView.transform = .identity
    self.primaryImageView.image = images[currentIndex]
    self.secondaryImageView.transform = .identity
  }
  
  @IBAction func pressButtonLike(_ sender: Any) {
    
    self.pressLike(isLiked: &isLiked, likeCounter: likeCounter, likeButton: likeButton)
  }
  
  
  @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
    if let animator = interactiveAnimator,
       animator.isRunning {
      return
    }
    
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
          self?.secondaryImageView.image = nil
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
    }
    else {
      self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
      self.secondaryImageView.image = images[currentIndex - 1]
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
    self.pageControl.currentPage = self.currentIndex
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension UIViewController {
  func pressLike(isLiked: inout Bool, likeCounter: UILabel, likeButton: UIButton) {
    likeCounterAnimation(likeCounter: likeCounter, isLiked: isLiked)
    likeButtonAnimation(isLiked: isLiked, likeButton: likeButton)
    isLiked = !isLiked
  }
  
  private func likeButtonAnimation(isLiked: Bool ,likeButton: UIButton) {
    likeButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: { [weak likeButton] in
                    likeButton?.transform = .identity
                   },
                   completion: nil)
    if isLiked {
      likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      likeButton.tintColor = UIColor.systemRed
    }
    else {
      likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      likeButton.tintColor = UIColor.systemBlue
    }
  }
  
  private func likeCounterAnimation(likeCounter: UILabel, isLiked: Bool) {
    if isLiked {
      UIView.transition(with: likeCounter,
                        duration: 0.5,
                        options: .transitionCurlDown,
                        animations: {   [weak likeCounter] in
                          guard let likeCounter = likeCounter else { return }
                          
                          likeCounter.text = "\(Int(likeCounter.text!)! + 1)"
                          
                        },
                        completion: nil)
    }
    else {
      UIView.transition(with: likeCounter,
                        duration: 0.5,
                        options: .transitionCurlUp,
                        animations: {   [weak likeCounter] in
                          guard let likeCounter = likeCounter else { return }
                          likeCounter.text = "\(Int(likeCounter.text!)! - 1)"
                        },
                        completion: nil)
    }
  }
}
