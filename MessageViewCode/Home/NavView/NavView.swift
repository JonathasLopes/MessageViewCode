//
//  NavView.swift
//  MessageViewCode
//
//  Created by Jonathas Lopes on 05/02/24.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavViewProtocol:AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}

class NavView: UIView {

    weak private var delegate:NavViewProtocol?
    
    func delegate(delegate:NavViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var navBackgroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    lazy var navBar:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var searchBar:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var searchLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite Aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var searchBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()
    
    let stackview:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        
        return stack
    }()
    
    lazy var conversationBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(self.tappedConversation), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var contactBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(self.tappedContact), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func tappedConversation() {
        self.delegate?.typeScreenMessage(type: .conversation)
        self.conversationBtn.tintColor = .systemPink
        self.contactBtn.tintColor = .black
    }
    
    @objc func tappedContact() {
        self.delegate?.typeScreenMessage(type: .contact)
        self.conversationBtn.tintColor = .black
        self.contactBtn.tintColor = .systemPink
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setUpConstraints()
    }
    
    func addElements() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.searchBar)
        self.navBar.addSubview(self.stackview)
        self.searchBar.addSubview(self.searchLabel)
        self.searchBar.addSubview(self.searchBtn)
        self.stackview.addArrangedSubview(self.conversationBtn)
        self.stackview.addArrangedSubview(self.contactBtn)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.stackview.leadingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.stackview.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -30),
            self.stackview.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.stackview.widthAnchor.constraint(equalToConstant: 100),
            self.stackview.heightAnchor.constraint(equalToConstant: 30),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchBtn.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 20),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
