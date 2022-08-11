//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var labelError: UILabel!
    
    private let presenter = loginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        if UserDefaults.standard.string(forKey: "session") != nil {
            performSegue(withIdentifier: "homeSegue", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func login(_ sender: Any) {
        if let username = username.text, let password = password.text {
            switch (username.isEmpty, password.isEmpty) {
            case (true, true):
                labelError.text = "Enter your username and password to continue."
            case (true, false):
                labelError.text = "Username is missing."
            case (false, true):
                labelError.text = "Password is missing."
            case (false, false):
                presenter.login(username: username, password: password)
                //performSegue(withIdentifier: "homeSegue", sender: self)
                break
            }
        }
    }
    
}

extension ViewController: LoginPresenterDelegate {
    func loginUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
    }
    
    func showMessage(msg: String) {
        DispatchQueue.main.async {
            self.labelError.text = msg
        }
    }
}
