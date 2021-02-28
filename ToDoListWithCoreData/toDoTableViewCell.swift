//
//  toDoTableViewCell.swift
//  toDoApp
//
//  Created by Takamiya Kengo on 2021/01/07.
//

import UIKit

class toDoTableViewCell: UITableViewCell{
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let boxLabel: UIImageView = {
      let label = UIImageView()
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.image = UIImage(named:"joey2")
        label.contentMode = .scaleAspectFill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(boxLabel)
        boxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        boxLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        boxLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        boxLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: boxLabel.trailingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: boxLabel.trailingAnchor, constant: 20).isActive = true
       
        contentView.addSubview(hStack)
        hStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        hStack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        hStack.addArrangedSubview(boxLabel)
        hStack.addArrangedSubview(vStack)
        
        contentView.addSubview(vStack)
        vStack.addSubview(nameLabel)
        vStack.addSubview(dateLabel)
        vStack.leadingAnchor.constraint(equalTo: boxLabel.trailingAnchor, constant: 20).isActive = true
        vStack.topAnchor.constraint(equalTo: hStack.topAnchor, constant: 0).isActive = true
        vStack.trailingAnchor.constraint(equalTo: hStack.trailingAnchor, constant: 0).isActive = true
        vStack.bottomAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 0).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
          contentView.isUserInteractionEnabled = true
          contentView.addGestureRecognizer(tap)
    }
   
    @objc func tapFunction() {
        if boxLabel.isHidden == false {
        boxLabel.isHidden = true
           let trans = CGAffineTransform(translationX:-50, y: 0)
            nameLabel.transform = trans
            dateLabel.transform = trans
        } else {
        boxLabel.isHidden = false
            let trans = CGAffineTransform(translationX: 0, y: 0)
            nameLabel.transform = trans
            dateLabel.transform = trans
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func change() {
        boxLabel.isHidden = true
    }
}

