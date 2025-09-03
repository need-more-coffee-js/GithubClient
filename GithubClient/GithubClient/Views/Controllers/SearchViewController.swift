//
//  SearchViewController.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let defaultUsers = ["apple", "microsoft", "google", "facebook", "twitter", "amazon"]

    private var allUsers: [String] {
        FavoritesManager.shared.favorites + defaultUsers
    }

    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter GitHub username"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/3.0),
            heightDimension: .absolute(130)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(130)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(PopularUserCell.self, forCellWithReuseIdentifier: PopularUserCell.identifier)
        return cv
    }()

    
    var router: Router
    private let popularUsers = ["apple", "microsoft", "google", "facebook", "twitter", "amazon","apple"]
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        allUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularUserCell.identifier, for: indexPath) as? PopularUserCell else {
            return UICollectionViewCell()
        }
        let username = allUsers[indexPath.row]
        cell.configure(username: username)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let username = allUsers[indexPath.row]
        router.pushMainViewController(username: username)
    }
}

