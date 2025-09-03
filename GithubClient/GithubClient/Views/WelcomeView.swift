//
//  WelcomeView.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class WelcomeView: UIView {
    
    var didTapStart: (() -> Void)?
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: Images.backgroundImage)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: Images.logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 12
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapStartButton(){
        didTapStart?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension WelcomeView {
    
    private func setupView(){
        addSubviews(backgroundImageView,logoImageView,loginButton)
    }
    
    private func style() {
        backgroundColor = .blue
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),

            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15)
            ])

    }

}
