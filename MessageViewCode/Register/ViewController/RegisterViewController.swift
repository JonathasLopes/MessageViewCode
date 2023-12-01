//
//  RegisterViewController.swift
//  LoginViewCode
//
//  Created by Jonathas Lopes on 01/08/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    var registerScreen:RegisterScreen?
    
    var auth:Auth?
    var alert:Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }

}

extension RegisterViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController:RegisterScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionregisterButton() {
        guard let register = self.registerScreen else {return}
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { result, error in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Houve um erro ao cadastrar!")
            } else {
                self.alert?.getAlert(title: "Sucesso", message: "Usuario cadastrado com sucesso!", completion: self.actionBackButton)
            }
        })
    }
}
