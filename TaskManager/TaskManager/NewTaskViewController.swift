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
    @IBOutlet weak var priorityPicker: UIPickerView!
    
    // MARK: - Variables
    weak var delegate: NewTaskDelegate?
    var categories: [String] = []
    var selectedCategory: String?
    var selectedPriority: Priority = .medium
    
    let tasksKey = "tasks_by_category"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Task"
        
        // Load categories
        categories = UserDefaults.standard.stringArray(forKey: "categories_list") ?? []
        selectedCategory = categories.first
        
        // Picker setup
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
        
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
            details: descriptionTextView.text,
            priority: selectedPriority
        )

        // Load stored tasks
        var allTasks = (try? JSONDecoder().decode(
            [String: [Task]].self,
            from: UserDefaults.standard.data(forKey: tasksKey) ?? Data()
        )) ?? [:]

        // Append the new one
        allTasks[category, default: []].append(newTask)

        // Save back
        if let encoded = try? JSONEncoder().encode(allTasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }

        delegate?.didCreateTask()
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Picker Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categories.count
        } else {
            return Priority.allCases.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            return categories[row]
        } else {
            return Priority.allCases[row].rawValue
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            selectedCategory = categories[row]
        } else {
            selectedPriority = Priority.allCases[row]
        }
    }
}
