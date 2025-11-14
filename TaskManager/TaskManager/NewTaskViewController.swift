//
//  NewTaskViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/9/25.
//

import UIKit

protocol NewTaskDelegate: AnyObject {
    func didCreateTask()
}

class NewTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!

    // MARK: - Variables
    weak var delegate: NewTaskDelegate?
    var selectedCategory: String?
    let tasksKey = "tasks_by_category"

    var categories: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Task"
        
        // Load categories
        categories = UserDefaults.standard.stringArray(forKey: "categories_list") ?? []
        selectedCategory = categories.first

        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        // Style description box
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 8
    }

    // MARK: - Save Task
    @IBAction func saveTaskPressed(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        guard let category = selectedCategory else { return }

        let newTask = Task(
            title: title,
            category: category,
            dueDate: datePicker.date,
            details: descriptionTextView.text
        )

        // Load dictionary of tasks
        var allTasks = (try? JSONDecoder().decode(
            [String: [Task]].self,
            from: UserDefaults.standard.data(forKey: tasksKey) ?? Data()
        )) ?? [:]

        // Append the new task
        allTasks[category, default: []].append(newTask)

        // Save back to UserDefaults
        if let encoded = try? JSONEncoder().encode(allTasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }

        delegate?.didCreateTask()
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
}
