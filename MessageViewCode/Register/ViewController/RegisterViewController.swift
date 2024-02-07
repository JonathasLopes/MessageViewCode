//
//  RegisterViewController.swift
//  LoginViewCode
//
//  Created by Jonathas Lopes on 01/08/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    var registerScreen:RegisterScreen?
    
    var auth:Auth?
    var firestore:Firestore?
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
        self.firestore = Firestore.firestore()
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
                //salvar dados no firebase
                if let userId = result?.user.uid {
                    self.firestore?.collection("usuarios").document(userId).setData([
                        "nome": self.registerScreen?.getName() ?? "",
                        "email": self.registerScreen?.getEmail() ?? "",
                        "id": userId
                    ])
                }
                
                self.alert?.getAlert(title: "Sucesso", message: "Usuario cadastrado com sucesso!", completion: {
                    let VC = HomeViewController()
                    let navVC = UINavigationController(rootViewController: VC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                })
            }
        })
    }
}
