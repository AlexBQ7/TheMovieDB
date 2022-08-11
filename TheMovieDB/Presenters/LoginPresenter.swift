//
//  LoginPresenter.swift
//  TheMovieDB
//
//  Created by David Alejandro Ruiz Hernandez on 10/08/22.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate {
    func loginUser()
    func showMessage(msg: String)
}

typealias PresenterDelegate = LoginPresenterDelegate & UIViewController

class loginPresenter {
    
    weak var delegate: PresenterDelegate?
    private let token = "1288e2b85807efeeabc728712a3d48ef"
    
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func login(username: String, password: String) {
        APIProvider.shared.login(username: username, password: password) {
            response in
            if response.success {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.synchronize()
                self.delegate?.loginUser()
            } else {
                self.delegate?.showMessage(msg: response.status_message ?? "Inicio de sesión fallido.")
            }
        } failure: { error in
            //Show Alert
            print(error ?? "Error")
        }
    }
    
}
