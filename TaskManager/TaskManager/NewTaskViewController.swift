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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var priorityPicker: UIPickerView!
    
    weak var delegate: NewTaskDelegate?
    var categories: [String] = []
    var selectedCategory: String?
    var selectedPriority: Priority = .medium
    
    let tasksKey = "tasks_by_category"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        titleTextField.text = ""
        descriptionTextView.text = ""
        datePicker.date = Date()

        selectedCategory = categories.first
        categoryPicker.selectRow(0, inComponent: 0, animated: false)

        selectedPriority = .medium
        priorityPicker.selectRow(Priority.allCases.firstIndex(of: .medium) ?? 0, inComponent: 0, animated: false)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Task"
        
        categories = UserDefaults.standard.stringArray(forKey: "categories_list") ?? []
        selectedCategory = categories.first
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
        
    }

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

        var allTasks: [String: [Task]] = [:]

        if let savedData = UserDefaults.standard.data(forKey: tasksKey) {
            if let decoded = try? JSONDecoder().decode([String: [Task]].self, from: savedData) {
                allTasks = decoded
            }
        }

        if allTasks[category] != nil {
            allTasks[category]!.append(newTask)
            }
        else {
            allTasks[category] = [newTask]
        }

                   
        if let encoded = try? JSONEncoder().encode(allTasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }

        delegate?.didCreateTask()
        self.tabBarController?.selectedIndex = 1

        
    }

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
