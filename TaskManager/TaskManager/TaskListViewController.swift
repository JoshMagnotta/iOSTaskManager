//
//  TaskListViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let tasksKey = "tasks_by_category"

    var allTasks: [Task] = []
    var filteredTasks: [Task] = []

    var groupedTasks: [Date: [Task]] = [:]
    var sortedDates: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterButtonPressed)
        )

        loadAllTasks()
        applyFilter(category: nil)
    }

    func loadAllTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let saved = try? JSONDecoder().decode([String: [Task]].self, from: data) {

            allTasks = saved.values.flatMap { $0 }   // merge all categories
        }
    }

    func applyFilter(category: String?) {
        if let category = category {
            filteredTasks = allTasks.filter { $0.category == category }
        } else {
            filteredTasks = allTasks
        }

        groupTasks()
        tableView.reloadData()
    }

    func groupTasks() {
        groupedTasks = Dictionary(grouping: filteredTasks) { task in
            task.dueDate.startOfDay()
        }

        sortedDates = groupedTasks.keys.sorted()
    }

    // MARK: - TABLE VIEW

    func numberOfSections(in tableView: UITableView) -> Int {
        sortedDates.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: sortedDates[section])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sortedDates[section]
        return groupedTasks[date]?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        let date = sortedDates[indexPath.section]
        let task = groupedTasks[date]![indexPath.row]

        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.category

        return cell
    }

    // MARK: - FILTER MENU

    @objc func filterButtonPressed() {
        let categories = ["All"] + (UserDefaults.standard.stringArray(forKey: "categories_list") ?? [])

        let alert = UIAlertController(title: "Filter Tasks", message: nil, preferredStyle: .actionSheet)

        for category in categories {
            alert.addAction(UIAlertAction(title: category, style: .default, handler: { _ in
                self.applyFilter(category: category == "All" ? nil : category)
            }))
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

extension Date {
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}

