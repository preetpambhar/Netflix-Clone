//
//  SplashViewController.swift
//  Swashray
//
//  Created by Preet Pambhar on 2025-06-07.
//

import UIKit

class SplashViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
          imageView.contentMode = .scaleAspectFit

          if UITraitCollection.current.userInterfaceStyle == .dark {
              imageView.image = UIImage(named: "Logo - White PNG")
          } else {
              imageView.image = UIImage(named: "Logo - Black PNG")
          }

          return imageView
     }()

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
         view.addSubview(logoImageView)
         logoImageView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             logoImageView.widthAnchor.constraint(equalToConstant: 350),
             logoImageView.heightAnchor.constraint(equalToConstant: 350)
         ])
         animateLogo()
     }
    
    private func animateLogo() {
        logoImageView.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 1.2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        }, completion: nil)
    }
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            logoImageView.image = traitCollection.userInterfaceStyle == .dark
                ? UIImage(named: "Logo - White PNG")
                : UIImage(named: "Logo - Black PNG")
        }
    }

}
