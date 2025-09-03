//
//  SearchViewController.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter GitHub username"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 130)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(PopularUserCell.self, forCellWithReuseIdentifier: PopularUserCell.identifier)
        return cv
    }()

    
    var router: Router
    private let popularUsers = ["apple", "microsoft", "google", "facebook", "twitter", "amazon"]
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        navigationItem.hidesBackButton = true
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let username = searchBar.text, !username.isEmpty else { return }
        router.pushMainViewController(username: username)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularUserCell.identifier, for: indexPath) as? PopularUserCell else {
            return UICollectionViewCell()
        }
        let username = popularUsers[indexPath.row]
        cell.configure(username: username)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let username = popularUsers[indexPath.row]
        router.pushMainViewController(username: username)
    }
}

