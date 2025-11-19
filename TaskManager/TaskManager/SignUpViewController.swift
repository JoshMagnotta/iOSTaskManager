//
//  SignUpViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBAction func signupButton(_ sender: Any) {
        guard let email = emailField.text,
                  let password = passwordField.text else { return }

            AuthManager.shared.signup(email: email, password: password) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        // After signup, take the user to login screen
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        self.showAlert(error.localizedDescription)
                    }
                }
            }
    }
    @IBAction func loginButton(_ sender: Any) {
    }
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
