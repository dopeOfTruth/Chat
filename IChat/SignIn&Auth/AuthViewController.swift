//
//  ViewController.swift
//  IChat
//
//  Created by Михаил Красильник on 14.04.2021.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)

    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .darkButton())
    
    let loginButton = UIButton(title: "Login", titleColor: .redForLoginTitle(), backgroundColor: .mainWhite(), isShadow: true)
    
    let googleButton = UIButton(title: "Coogle", titleColor: .black, backgroundColor: .white, isShadow: true)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        googleButton.customizeGoogleButton()
        setupConstrains()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        loginVC.delegate = self
        signUpVC.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
    }

    @objc private func emailButtonTapped() {
        
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
}

//MARK: - Setup constrains

extension AuthViewController {
    
    private func setupConstrains() {
        
        let googleView = ButtonFormView(button: googleButton, label: googleLabel)
        let emailView = ButtonFormView(button: emailButton, label: emailLabel)
        let loginView = ButtonFormView(button: loginButton, label: alreadyOnboardLabel)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 110),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension AuthViewController: AuthNavigationDelegat {
    
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    
}


//MARK: - GIDSignInDelegate
extension AuthViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleLogin(user: user, error: error) { (result) in
            
            switch result {
            
            case .success(let mUser):
                FirestoreService.shared.getUserData(user: mUser) { (result) in
                    switch result {
                    case .success(let mUser):
                        
                        UIApplication.getTopViewController()?.showAlert(title: "Success", message: "You are registered") {
                            let mainTabBarVC = MainTabBarController(currentUser: mUser)
                            mainTabBarVC.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainTabBarVC, animated: true, completion: nil)
                        }
                    case .failure(_):
                        UIApplication.getTopViewController()?.showAlert(title: "Success", message: "You are registered") {
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: mUser), animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription )
            }
        }
    }
}

//MARK: - SwiftUI

import SwiftUI

struct AuthVCProvider: PreviewProvider {
    
    static var previews: some View {
        ConteinerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ConteinerView: UIViewControllerRepresentable {
        
        let authViewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            authViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
