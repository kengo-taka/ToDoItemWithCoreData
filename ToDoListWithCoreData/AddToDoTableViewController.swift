//
//  AddToDoTableViewController.swift
//  toDoApp
//
//  Created by Takamiya Kengo on 2021/01/07.
//

import UIKit

protocol AddToDoItemDelegate: class{
    func add(_ toDoItem: toDoItem)
    func edit(_ toDoItem: toDoItem,_ row: Int,_ section:Int)
}

class AddToDoTableViewController: UITableViewController {
let headers = ["Name","Due date","Priority"]
    let nameCell = AddToDoTableViewCell()
    let dateCell = AddToDoTableViewCell2()
    let priorityCell = AddToDoTableViewCell3()
    let saveButton = UIBarButtonItem(barButtonSystemItem:.save, target: self, action: #selector(saveToDo))

    weak var delegate: AddToDoItemDelegate?
    
    var toDoItem: toDoItem?
    var row: Int?
    var section: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil {
            title = "Add To Do"
        } else {
            title = "Edit To Do"
            nameCell.textField.text = toDoItem?.name
            dateCell.textField.text = toDoItem?.date
          priorityCell.textField.text = toDoItem?.priority
        }
           
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissFunc))
        navigationItem.rightBarButtonItem = saveButton

        nameCell.textField.addTarget(self, action: #selector(textEditingChanged), for: .editingChanged)
        
        updateSaveButtonState()
    }

    @objc func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func dismissFunc() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveToDo() {
        if toDoItem == nil {
          let itemToDo = ToDoListWithCoreData.toDoItem(name: nameCell.textField.text! ,date:dateCell.textField.text!,priority: priorityCell.textField.text!)
        delegate?.add(itemToDo)
        } else {
          let itemToDo = ToDoListWithCoreData.toDoItem(name: nameCell.textField.text! ,date: dateCell.textField.text!,priority: priorityCell.textField.text!)
            let rowValue = row
            let sectionValue = section
            delegate?.edit(itemToDo, rowValue!, sectionValue!)
            dismissFunc()
        }
        dismissFunc()
    }
    
    private func updateSaveButtonState() {
        let nameText = nameCell.textField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == [0,0] {
            return nameCell
        } else if indexPath == [1,0]  {
            return dateCell
        } else {
          return priorityCell
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }


}
