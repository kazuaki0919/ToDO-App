//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by 並木一晃 on 2020/02/05.
//  Copyright © 2020 kazuaki.namiki. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categorySegmentedController: UISegmentedControl!
    
    //MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var taskCategory = "やること"
    
    //MARK: - Action of Buttons
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        //TextFieldに何も入力されてない時、何もせずにViewControllerに戻る。
        let taskName = taskTextField.text
        if taskName == "" {
            dismiss(animated: true, completion: nil)
            return
        }
        
        //context(データベースを扱うのに必要)を定義
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        task.name = taskName
        task.category = taskCategory
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func categoryChosen(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            taskCategory = "やること"
        case 1:
            taskCategory = "買うもの"
        case 2:
            taskCategory = "課題"
        default:
            "やること"
        }
    }
    
    //MARK: -


}
