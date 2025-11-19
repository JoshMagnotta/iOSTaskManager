//
//  LoginViewController.swift
//  TaskManager
//
//  Created by Joshua Magnotta on 11/18/25.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBAction func loginButton(_ sender: Any) {
        
        guard let email = emailField.text,
                  let password = passwordField.text else { return }

        AuthManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    UserDefaults.standard.set(email, forKey: "loggedInEmail")
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.presentMainApp()
                    print("Logged in!")

                case .failure(let error):
                    self.showErrorAlert(message: error.localizedDescription)
                }
            }
        }

    }
    @IBAction func signUpButton(_ sender: Any) {
    }
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func presentMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
