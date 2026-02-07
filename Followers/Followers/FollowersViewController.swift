//
//  FollowersViewController.swift
//  Followers
//
//  Created by Karla Lopez on 16/01/26.
//

//
//  FollowersViewController.swift
//  Followers
//
//  Created by Karla Lopez on 16/01/26.
//

import UIKit

final class FollowersViewController: UIViewController {

    // MARK: - Properties
    private let username: String
    private var followers: [FollowerDTO] = []
    private var userAvatarUrl: String = ""


    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 12
        let availableWidth = UIScreen.main.bounds.width - (padding * 4)
        let itemWidth = availableWidth / 3

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        layout.sectionInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    // MARK: - Init
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        title = username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureCollectionView()
        configureNavigationBar()
        fetchFollowers()
    }

    // MARK: - UI
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            FollowerCell.self,
            forCellWithReuseIdentifier: FollowerCell.reuseID
        )
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(addToFavorites)
        )
    }

    // MARK: - Networking
    private func fetchFollowers() {
        NetworkManager.shared.fetchFollowers(username: username) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let followers):
                    self.followers = followers

                    if let firstFollower = followers.first {
                        self.userAvatarUrl = firstFollower.avatarUrl
                    }

                    self.collectionView.reloadData()

                case .failure(let error):
                    self.presentAlert(
                        title: "Error",
                        message: error.localizedDescription
                    )
                }
            }
        }
    }


    // MARK: - Favorites
    @objc private func addToFavorites() {
        let favorite = Favorite(
            login: username,
            avatarUrl: userAvatarUrl
        )

        do {
            try FavoritesManager.save(favorite: favorite)
            presentAlert(
                title: "Agregado",
                message: "\(username) fue agregado a favoritos"
            )
        } catch {
            presentAlert(
                title: "Error",
                message: error.localizedDescription
            )
        }
    }

}

// MARK: - UICollectionViewDataSource
extension FollowersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        followers.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FollowerCell.reuseID,
            for: indexPath
        ) as! FollowerCell

        let follower = followers[indexPath.item]
        cell.set(follower: follower)

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FollowersViewController: UICollectionViewDelegate {}
