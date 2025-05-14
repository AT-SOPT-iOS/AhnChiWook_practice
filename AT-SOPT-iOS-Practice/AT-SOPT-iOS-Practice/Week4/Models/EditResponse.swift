//
//  EditResponse.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//


struct EditResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: EditResponseData?
}

struct EditResponseData: Codable {
    let nickname: String
}