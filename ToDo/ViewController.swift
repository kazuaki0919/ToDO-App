//
//  ViewController.swift
//  ToDo
//
//  Created by 並木一晃 on 2020/02/05.
//  Copyright © 2020 kazuaki.namiki. All rights reserved.
//

import UIKit
import CoreData  //NSFetchRequestを使うときは忘れずに！！

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK - Properties
    
    //Table Viewの宣言
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks:[Task] = []
    var tasksToShow:[String:[String]] = ["やること":[], "買うもの":[], "課題":[]]
    
    let taskCategories:[String] = ["やること", "買うもの", "課題"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        taskTableView.reloadData()
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            tasks = try context.fetch(fetchRequest)
            
            for key in tasksToShow.keys {
                tasksToShow[key] = []
            }
            
            for task in tasks {
                tasksToShow[task.category!]?.append(task.name!)
            }
        } catch {
            print("Fetchng Failed.")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskCategories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]
        
        cell.textLabel?.text = "\(cellData!)"
        
        return cell
    }


}

