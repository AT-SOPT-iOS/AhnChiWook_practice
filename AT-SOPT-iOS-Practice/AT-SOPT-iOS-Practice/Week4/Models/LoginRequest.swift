//
//  LoginRequest.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//


import UIKit

// MARK: - Request Model
struct LoginRequest: Codable {
    let loginId: String
    let password: String
}

// MARK: - Response Model
struct LoginResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: UserData?
}

struct UserData: Codable {
    let userId: Int
}
