//
//  HomeViewController.swift
//  MessageViewCode
//
//  Created by Jonathas Lopes on 05/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    var homeScreen:HomeScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        
    }
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = self.homeScreen
    }

}
