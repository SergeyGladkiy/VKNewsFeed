//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Serg on 04/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthServiceProtocol!
    
    private weak var enterVK: UIButton!
    
    private var arrayConstraints = [NSLayoutConstraint]()
    
    init(authService: AuthServiceProtocol) {
        
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AuthViewController {
    func layout() {
        
        let buttonEnter = RoundedButton()
        buttonEnter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonEnter)
        buttonEnter.setTitle("Войти в VK", for: .normal)
        let widthEnter = buttonEnter.widthAnchor.constraint(equalToConstant: 120)
        let heightEnter = buttonEnter.heightAnchor.constraint(equalToConstant: 60)
        let centerXEnter = buttonEnter.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYEnter = buttonEnter.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        arrayConstraints.append(contentsOf: [widthEnter, heightEnter, centerXEnter, centerYEnter])
        enterVK = buttonEnter
        enterVK.addTarget(self, action: #selector(buttonEnterAction), for: .touchUpInside)
        NSLayoutConstraint.activate(arrayConstraints)
    }
}

extension AuthViewController {
    @objc private func buttonEnterAction() {
        authService.wakeUpSeccion()
    }
}
