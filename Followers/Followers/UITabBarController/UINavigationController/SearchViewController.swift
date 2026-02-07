//
//  SearchViewController.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - UI Elements

    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "github-logo"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a username"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .go
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let getFollowersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Followers", for: .normal)
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        view.backgroundColor = .systemBackground

        setupUI()
        setupActions()
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(getFollowersButton)

        NSLayoutConstraint.activate([
            // Logo
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),

            // TextField
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),

            // Button
            getFollowersButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            getFollowersButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            getFollowersButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupActions() {
        usernameTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        getFollowersButton.addTarget(
            self,
            action: #selector(getFollowersTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    @objc private func textDidChange() {
        let text = usernameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        getFollowersButton.isHidden = text.isEmpty
    }

    @objc private func getFollowersTapped() {
        let username = usernameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !username.isEmpty else { return }

        let followersVC = FollowersViewController(username: username)
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    

}

