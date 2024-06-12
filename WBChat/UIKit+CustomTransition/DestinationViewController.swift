//
//  DestinationViewController.swift
//  WBChat
//
//  Created by Александр on 10.06.2024.
//

import Foundation
import UIKit

final class DestinationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Destination"
        view.backgroundColor = .systemOrange
        setupViews()
    }
    var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вернуться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        button.layer.masksToBounds = true
        return button
    }()
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "pc")
        iv.tintColor = .systemRed
        return iv
    }()
    
    
    private func setupViews() {
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
