//
//  UIViewController+Alert.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import UIKit

extension UIViewController {

    func presentAlert(
        title: String,
        message: String,
        buttonTitle: String = "OK"
    ) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertVC.addAction(
            UIAlertAction(title: buttonTitle, style: .default)
        )

        present(alertVC, animated: true)
    }
}

