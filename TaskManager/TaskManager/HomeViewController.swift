//
//  HomeViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    // TODO: Save to User Default
    @IBAction func addCategoryPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New Category",
                                          message: "Enter a name for the category",
                                          preferredStyle: .alert)

            alert.addTextField { textField in
                textField.placeholder = "Category Name"
            }

            let addAction = UIAlertAction(title: "Add", style: .default) { _ in
                if let categoryName = alert.textFields?.first?.text, !categoryName.isEmpty {

                    self.categories.append(categoryName)

                    UserDefaults.standard.set(self.categories, forKey: self.categoriesKey)

                    self.tableView.reloadData()
                }
            }

            alert.addAction(addAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)

    }
    // TODO: Temporary mock data (later you’ll load from UserDefaults)
    var categories: [String] = []

    
    let categoriesKey = "categories_list"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail") {
            navigationItem.title = "Welcome, \(email)"
           } else {
               title = "Home"
           }
    


        tableView.delegate = self
        tableView.dataSource = self
        
        // Load saved categories, or default ones on first launch
            if let saved = UserDefaults.standard.array(forKey: categoriesKey) as? [String] {
                categories = saved
            } else {
                categories = ["Assignments", "Exams", "Personal", "Work"] // First time launch defaults
            }
        
    }

    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    // Display each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

    // Handle tap → go to Task List
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
