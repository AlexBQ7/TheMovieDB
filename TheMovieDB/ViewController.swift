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
    }

    @IBAction func login(_ sender: Any) {
        if let username = username.text, let password = password.text {
            switch (username.isEmpty, password.isEmpty) {
            case (true, true):
                labelError.text = "Enter your username and password to continue."
            case (true, false):
                labelError.text = "Username is missing."
            case (false, true):
                labelError.text = "Password id missing."
            case (false, false):
                //presenter.login(username: username, password: password)
                performSegue(withIdentifier: "homeSegue", sender: self)
                break
            }
        }
    }
    
}

extension ViewController: LoginPresenterDelegate {
    func loginUser() {
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
    func showMessage(msg: String) {
        labelError.text = msg
    }
}
