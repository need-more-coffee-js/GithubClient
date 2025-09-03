//
//  PopularUserCell.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

final class PopularUserCell: UICollectionViewCell {
    
    static let identifier = "PopularUserCell"
    
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 35
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemBackground
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            usernameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        usernameLabel.text = nil
    }
    
    func configure(username: String) {
        usernameLabel.text = username
        let urlString = "https://github.com/\(username).png"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.avatarImageView.image = image
                    }
                }
            }.resume()
        }
    }

}

