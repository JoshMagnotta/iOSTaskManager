//
//  NewTaskViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var categoryName: String?
    var delegate: TaskListViewController?
    let tasksKey = "tasks_by_category"


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Task"
    }

    @IBAction func saveTaskPressed(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
                  let category = categoryName else { return }

            let newTask = Task(title: title, dueDate: datePicker.date)

            // Load all tasks
            var allTasks = (try? JSONDecoder().decode([String: [Task]].self,
                             from: UserDefaults.standard.data(forKey: tasksKey) ?? Data())) ?? [:]

            // Append task to correct category
            allTasks[category, default: []].append(newTask)

            // Save back to UserDefaults
            if let encoded = try? JSONEncoder().encode(allTasks) {
                UserDefaults.standard.set(encoded, forKey: tasksKey)
            }

            delegate?.loadTasks()
            delegate?.tableView.reloadData()
            navigationController?.popViewController(animated: true)
    }
}
