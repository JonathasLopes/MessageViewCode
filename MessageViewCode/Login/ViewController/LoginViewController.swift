//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Jonathas Lopes on 14/07/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var loginScreen:LoginScreen?
    var auth:Auth?
    var alert:Alert?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController:LoginScreenProtocol {
    func actionLoginButton() {
        guard let login = self.loginScreen else {return}
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { result, error in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Houve um erro ao fazer login!")
            } else {
                if result == nil {
                    self.alert?.getAlert(title: "Atenção", message: "Tivemos um problema inesperado, tente novamente mais tarde!")
                } else {
                    self.alert?.getAlert(title: "Parabéns", message: "Usuario logado com sucesso!")
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc:RegisterViewController = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
