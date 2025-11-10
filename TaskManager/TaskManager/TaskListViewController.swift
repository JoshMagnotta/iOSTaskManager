//
//  TaskListViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    @IBAction func addTaskPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewTaskViewController") as! NewTaskViewController
            vc.categoryName = categoryName
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
    }
    
    let tasksKey = "tasks_by_category"
    var categoryName: String?
    var tasks: [Task] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryName ?? "Tasks"

        tableView.delegate = self
        tableView.dataSource = self
        
        loadTasks()
    }
    
    func loadTasks() {
        guard let category = categoryName else { return }

        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let saved = try? JSONDecoder().decode([String: [Task]].self, from: data),
           let tasksForCategory = saved[category] {
            tasks = tasksForCategory
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        return cell
    }

}
