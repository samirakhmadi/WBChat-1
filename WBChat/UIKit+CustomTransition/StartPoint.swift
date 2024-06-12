//
//  StartPoint.swift
//  WBChat
//
//  Created by Александр on 10.06.2024.
//

import Foundation
import UIKit

final class StartPointVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupViews()
    }
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на VC2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        return button
    }()
    
    private func setupViews() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 150)

        ])
        
        button.layer.cornerRadius = button.frame.height / 2
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        let vc = DestinationVC()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        button.layer.cornerRadius = button.frame.size.height / 2
    }
}


extension UIViewController: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> (
        any UIViewControllerAnimatedTransitioning
    )? {
        RectangleAnimator(duration: 1.5, transitionMode: .present)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        RectangleAnimator(duration: 1.5, transitionMode: .dismiss)
    }
}


import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        StartPointVC()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
            .ignoresSafeArea()
    }
}
