//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-19.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"

    private let containerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .secondarySystemBackground
           view.layer.cornerRadius = 12
           view.clipsToBounds = true
           return view
       }()
    
       private let titleLabel: UILabel = {
           let label  = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.numberOfLines = 0
           label.lineBreakMode = .byTruncatingTail
           label.font = UIFont.preferredFont(forTextStyle: .headline)
           return label
       }()
       
       private let titlePosterUIImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.clipsToBounds = true
           imageView.layer.cornerRadius = 8
           return imageView
       }()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           contentView.backgroundColor = .clear
           contentView.addSubview(containerView)
           containerView.addSubview(titlePosterUIImageView)
           containerView.addSubview(titleLabel)
           applyConstraints()
       }
       
       private func applyConstraints() {
           NSLayoutConstraint.activate([
               // ContainerView fills the cell with padding
               containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
               containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

               // Poster image on the left
               titlePosterUIImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
               titlePosterUIImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
               titlePosterUIImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
               titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 150),
               titlePosterUIImageView.heightAnchor.constraint(equalToConstant: 120),

               // Title label on the right
               titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
               titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
               titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
               titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
           ])
       }
       
       public func configure(with model: TitleViewModel) {
           titleLabel.text = model.titleName
           if let url = URL(string: model.posterURL) {
               titlePosterUIImageView.sd_setImage(with: url)
           }
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
