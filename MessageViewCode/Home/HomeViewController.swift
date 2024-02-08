//
//  HomeViewController.swift
//  MessageViewCode
//
//  Created by Jonathas Lopes on 05/02/24.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var auth:Auth?
    var db:Firestore?
    var userId:String?
    var userEmail:String?
    var screenContact:Bool?
    var alert:Alert?
    var homeScreen:HomeScreen?
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = self.homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
    }
    
    private func configHomeView() {
        self.homeScreen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.homeScreen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        self.alert = Alert(controller: self)
    }

}

extension HomeViewController:NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            self.screenContact = true
        case .conversation:
            self.screenContact = false
        }
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
