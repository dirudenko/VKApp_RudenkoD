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
  @IBOutlet weak var viewForAnimation: UIView!
  
  private var interactiveAnimator: UIViewPropertyAnimator!
  private var isLeftSwipe = false
  private var isRightSwipe = false
  private var chooseFlag = false
  private var currentIndex = Int()
  private var viewTranslation = CGPoint(x: 0, y: 0)
  var friendId = Session.shared.userId.last
  var indexPhoto: Int?
  private var urlArray = [String]()
  private let databaseService = DatabaseServiceImpl()
  private let networkService = NetworkServices()
  var presenter: PhotoPresenterProtocol!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = PhotoPresenter(view: self, networkService: networkService, databaseService: databaseService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getAnimatedPhoto()
    setup()
  }
  
  func setup() {
    primaryImageView.isUserInteractionEnabled = true
    let swipe = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
    let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    primaryImageView.addGestureRecognizer(recognizer)
    viewForAnimation.addGestureRecognizer(swipe)
    
    primaryImageView.frame = viewForAnimation.bounds
    secondaryImageView.frame = viewForAnimation.bounds
    primaryImageView.contentMode = .scaleAspectFill
    secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
    primaryImageView.sd_setImage(with: URL(string: (urlArray[indexPhoto ?? 0])))
  }
}

extension AnimatedPhotosViewController: PhotoProtocol {
  func success() {
    guard let albumArray = presenter.photos,
          let id = friendId else { return }
    albumArray.filter {
      $0.ownerID == id
    }
    .forEach {
      let item = $0.sizeList
      item.forEach{
        if $0.type == "x"  {
          self.urlArray.append($0.url)
        }
      }
    }
  }
}

extension AnimatedPhotosViewController {
  
  @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
    if let animator = interactiveAnimator,
       animator.isRunning {
      return
    }
    currentIndex = indexPhoto ?? 0
    switch recognizer.state {
    case .began:
      primaryImageView.transform = .identity
      primaryImageView.sd_setImage(with: URL(string: urlArray[currentIndex]))
      secondaryImageView.transform = .identity
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
      var translation = recognizer.translation(in: view)
      if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
        if currentIndex == (urlArray.count - 1) {
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
        if currentIndex == 0 {
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
      var translation = recognizer.translation(in: view)
      
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
    primaryImageView.transform = .identity
    secondaryImageView.transform = .identity
    primaryImageView.sd_setImage(with: URL(string: urlArray[currentIndex]))
    
    if isLeft {
      secondaryImageView.sd_setImage(with: URL(string: urlArray[currentIndex + 1]))
      secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
      secondaryImageView.alpha = 1
      
    }
    else {
      secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
      secondaryImageView.sd_setImage(with: URL(string: urlArray[currentIndex - 1]))
      secondaryImageView.alpha = 1
    }
  }
  
  
  private func onChangeCompletion(isLeft: Bool) {
    primaryImageView.transform = .identity
    secondaryImageView.transform = .identity
    if isLeft {
      currentIndex += 1
    }
    else {
      currentIndex -= 1
    }
    primaryImageView.sd_setImage(with: URL(string: urlArray[currentIndex]))
    viewForAnimation.bringSubviewToFront(primaryImageView)
    indexPhoto = currentIndex
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
        dismiss(animated: false)
      }
    default:
      break
    }
  }
}



