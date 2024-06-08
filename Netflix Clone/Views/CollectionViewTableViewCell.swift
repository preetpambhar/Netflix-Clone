//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-08.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
    }

    
    required init? (coder: NSCoder){
        fatalError()
    }
}
