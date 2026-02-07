//
//  GHError.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import Foundation

import Foundation

import Foundation

enum GHError: String, Error {
    case invalidURL = "La URL es inválida."
    case unableToComplete = "Revisa tu conexión a internet."
    case invalidResponse = "Respuesta inválida del servidor."
    case invalidData = "Los datos recibidos son incorrectos."
    case userNotFound = "Usuario no encontrado."
    case alreadyInFavorites = "Este usuario ya está en favoritos."
}



