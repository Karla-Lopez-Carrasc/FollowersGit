import UIKit

final class FavoritesVC: UIViewController {

    // MARK: - Properties
    private var favorites: [Favorite] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let padding: CGFloat = 12
        let availableWidth = UIScreen.main.bounds.width - (padding * 4)
        let itemWidth = availableWidth / 3

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"

        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }

    // MARK: - UI
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    // MARK: - Data
    private func loadFavorites() {
        favorites = FavoritesManager.getFavorites()
        collectionView.reloadData()
    }

    private func confirmDelete(favorite: Favorite) {
        let alert = UIAlertController(
            title: "Eliminar favorito",
            message: "¿Deseas eliminar a \(favorite.login) de favoritos?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive) { [weak self] _ in
            FavoritesManager.remove(favorite: favorite)
            self?.loadFavorites()
        })

        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FollowerCell.reuseID,
            for: indexPath
        ) as! FollowerCell

        let favorite = favorites[indexPath.item]

        // Re-usa tu celda actual sin “producción extra”
        let follower = FollowerDTO(login: favorite.login, avatarUrl: favorite.avatarUrl)
        cell.set(follower: follower)

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesVC: UICollectionViewDelegate {

    // Tap -> navegar a followers
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.item]
        let followersVC = FollowersViewController(username: favorite.login)
        navigationController?.pushViewController(followersVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {

        let favorite = favorites[indexPath.item]

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            let delete = UIAction(
                title: "Eliminar",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                self?.confirmDelete(favorite: favorite)
            }

            return UIMenu(title: "", children: [delete])
        }
    }
}
