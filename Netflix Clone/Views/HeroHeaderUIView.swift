//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-09.
//

import UIKit

class HeroHeaderUIView: UIView {
    
//    private let downloadButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("About US", for: .normal)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 5
//        return button
//    }()
//    private let playButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Connect Now", for: .normal)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 5
//        return button
//    }()
    
    private let connectButton: UIButton = {
           let button = UIButton()
           button.setTitle("Connect Now", for: .normal)
           button.layer.borderColor = UIColor.white.cgColor
           button.layer.borderWidth = 1
           button.translatesAutoresizingMaskIntoConstraints = false
           button.layer.cornerRadius = 5
           button.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
           return button
       }()
    
    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "StrangerThings")
        return imageView
    }()
    private func addGradiant(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradiant()
        addSubview(connectButton)
       applyConstrains()
    }
    
    private func applyConstrains(){
        let connectButtonConstraints = [
                    connectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                    connectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                    connectButton.widthAnchor.constraint(equalToConstant: 120)
                ]
                
                NSLayoutConstraint.activate(connectButtonConstraints)
    }
    
    @objc private func connectButtonTapped() {
           if let url = URL(string: "https://web.whatsapp.com/") {
               UIApplication.shared.open(url)
           }
       }
       
    
    public func configure(with model: TitleViewModel){
        guard let url  = URL(string: "https://image.tmdb.org/t/p/original\(model.posterURL)") else {return}
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    
}

