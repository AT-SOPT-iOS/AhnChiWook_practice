//
//  LoginNicknameResponse.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//

struct LoginNicknameResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: LoginNicknameData?
}

struct LoginNicknameData: Codable {
    let nickname: String
}
