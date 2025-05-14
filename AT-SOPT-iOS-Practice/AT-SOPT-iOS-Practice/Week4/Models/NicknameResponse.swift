//
//  NicknameResponse.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//


struct NicknameListResponseWrapper: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: NicknameListResponseModel
}

struct NicknameListResponseModel: Codable {
    let nicknameList: [String]
}
