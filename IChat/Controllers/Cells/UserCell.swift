//
//  UserCell.swift
//  IChat
//
//  Created by Михаил Красильник on 18.04.2021.
//

import UIKit
import SDWebImage

class UserCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "UserCell"
    
    let userImageView = UIImageView()
    
    let username = UILabel(text: "ololoshechka", font: .laoSangamMN20())
    
    let containerView = UIView()
    
    
    private func setupConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.backgroundColor = .systemPink
        
        self.addSubview(containerView)
        containerView.addSubview(userImageView)
        containerView.addSubview(username)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            userImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            username.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            username.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            username.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        
        
        self.layer.cornerRadius = 4
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U: Hashable {
        guard let user: MUser = value as? MUser else { return }
        username.text = user.username
        guard let url = URL(string: user.avatarStringURL) else { return }
        userImageView.sd_setImage(with: url, completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - SwiftUI

import SwiftUI

struct UserCellProvider: PreviewProvider {
    
    static var previews: some View {
        ConteinerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ConteinerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
