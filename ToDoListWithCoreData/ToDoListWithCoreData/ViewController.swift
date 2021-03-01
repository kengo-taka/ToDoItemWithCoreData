//
//  ViewController.swift
//  toDoApp
//
//  Created by Takamiya Kengo on 2021/01/06.
//

import UIKit
import MessageUI
import CoreData

class ViewController: UITableViewController,AddToDoItemDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate, NSFetchedResultsControllerDelegate{

    let cellId = "toDoCell"
    let toDoCell = toDoTableViewCell()
    var sectionTitles: [String] = ["High Priority", "Medium Priority","Low Priority"]
    
  lazy var fetchedResultsController: NSFetchedResultsController<ManagedToDoItem> = {
    let request: NSFetchRequest<ManagedToDoItem> = ManagedToDoItem.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
//    request.predicate = NSPredicate(format: "ANY articles.searchText CONTAINS[c] %@", searchText)
    
    var container: NSPersistentContainer = AppDelegate.persistentContainer

    let frc = NSFetchedResultsController<ManagedToDoItem>(
      fetchRequest: request,
      managedObjectContext: container.viewContext,
      sectionNameKeyPath: "priority",
      cacheName: nil)
    frc.delegate = self
    return frc
  }()
  
    var toDoItems: [ManagedToDoItem] = []
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var container: NSPersistentContainer? = AppDelegate.persistentContainer

    override func viewDidLoad() {
        super.viewDidLoad()
      updateUI()
        title = "You Can Do It"

        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(toDoTableViewCell.self, forCellReuseIdentifier: cellId)

        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(multipleDelete))
      navigationItem.rightBarButtonItems = [addButton,deleteButton]

    }
   
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }

    @objc func multipleDelete () {
        if (tableView.indexPathsForSelectedRows != nil) {
        let sortedIndexPaths = tableView.indexPathsForSelectedRows!.sorted(by: {$0.row > $1.row})
        for indexPathList in sortedIndexPaths {
//          tableView.deleteRows(at: [indexPathList], with: .middle)
          let deletesItem = fetchedResultsController.object(at: indexPathList)
          fetchedResultsController.managedObjectContext.delete(deletesItem)
          saveItems()
          updateUI()
        }
        }
      saveItems()
    }
    
    @objc func addToDo () {
        let addEditVC = AddToDoTableViewController(style: .grouped)
        addEditVC.delegate = self
        let addToDoVC = UINavigationController(rootViewController: addEditVC)
        present(addToDoVC, animated: true, completion: nil)
    }
    
  func updateUI() {
    try? fetchedResultsController.performFetch()
    tableView.reloadData()
  }
  
    func add(_ toDoItem: toDoItem) {
      let newItem = ManagedToDoItem(context: context)
      newItem.name = toDoItem.name
      newItem.date = toDoItem.date
      newItem.priority = toDoItem.priority
//      toDoItems.append(newItem)
      saveItems()
       updateUI()
    }
    
  func saveItems() {
    do {
      try context.save()
    } catch {
      print("Error")
    }
    self.tableView.reloadData()
  }
  
    func edit(_ toDoItem: toDoItem,_ row: Int, _ section:Int) {
      let index = IndexPath(row: row, section: section)
//      toDoItems.remove(at:row)
      let source = fetchedResultsController.object(at: index)
//    let newItem = ManagedToDoItem(context: context)
      source.name = toDoItem.name
      source.date = toDoItem.date
      source.priority = toDoItem.priority
//      toDoItems.insert(newItem, at:row)
    saveItems()
      tableView.reloadRows(at: [index], with: .automatic)
      tableView.deselectRow(at: index, animated: true)
      tableView.reloadData()
      updateUI()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false
        tableView.allowsSelection = false
        tableView.deselectRow(at: indexPath, animated: false)
        }
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        tableView.deselectRow(at: indexPath, animated: false)
//        return .delete
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
      return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if let sections = fetchedResultsController.sections, sections.count > 0 {
        return sections[section].numberOfObjects
      } else {
        return 0
      }
    }
  
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! toDoTableViewCell
      let source = fetchedResultsController.object(at: indexPath)
      cell.nameLabel.text = source.name
      cell.dateLabel.text = "Deadline : \(source.date ?? "Tommorow")"
        cell.showsReorderControl = true
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditVC = AddToDoTableViewController(style: .grouped)
        addEditVC.delegate = self
      let source = fetchedResultsController.object(at: indexPath)
      let editItem = toDoItem(name: source.name! ,date: source.date!,priority: source.priority!)
              addEditVC.toDoItem = editItem
        addEditVC.row = indexPath.row
        addEditVC.section = indexPath.section
        let addToDoVC = UINavigationController(rootViewController: addEditVC)
        present(addToDoVC, animated: true, completion: nil)

    }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    if let sections = fetchedResultsController.sections, sections.count > 0 {
//      return sections[section].name
//    } else {
//      return nil
//    }
    switch fetchedResultsController.sections?[section].name{
    case "High Priority":
      return "High Priority"
    case "Medium Priority":
      return "Medium Priority"
    case "Low Priority":
      return "Low Priority"
    default:
      return nil
    }
  }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//      let deletesItem = fetchedResultsController.object(at: indexPathList)
//      fetchedResultsController.managedObjectContext.delete(deletesItem)
//        let removedToDoItem = toDoItems.remove(at: sourceIndexPath.row)
//        toDoItems.insert(removedToDoItem, at: destinationIndexPath.row)
//
//    }
}
