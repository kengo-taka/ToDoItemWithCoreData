//
//  AddToDoTableViewCell.swift
//  toDoApp
//
//  Created by Takamiya Kengo on 2021/01/07.
//

import UIKit

class AddToDoTableViewCell: UITableViewCell {

    let textField:UITextField = {
        let field = UITextField()
       
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class AddToDoTableViewCell2: UITableViewCell {

    let textField:UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        contentView.addGestureRecognizer((tapGesture))
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        textField.text = dateFormatter.string(from: datePicker.date)
        contentView.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddToDoTableViewCell3: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return priorityArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = priorityArray[row]
        return row
     }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  let selected = priorityArray[row] // selected item
    textField.text = selected
  }
  
  let priorityArray = ["High Priority","Medium Priority","Low Priority"]

  let textField:UITextField = {
      let field = UITextField()
      field.borderStyle = .roundedRect
      field.translatesAutoresizingMaskIntoConstraints = false
      return field
  }()
    let picker:UIPickerView = {
        let picker = UIPickerView()
      picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      contentView.addSubview(textField)
      textField.inputView = picker
      textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
      textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
      textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
      textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
      
      
//        contentView.addSubview(picker)
//      picker.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0).isActive = true
//      picker.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
//      picker.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
//      picker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
      picker.delegate = self
      picker.dataSource = self
//
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
