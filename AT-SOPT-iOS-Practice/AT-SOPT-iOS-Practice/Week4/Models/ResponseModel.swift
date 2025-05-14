//
//  ResponseModel.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//

struct RegisterResponseWrapper: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: RegisterResponseBody
}

struct RegisterResponseBody: Codable {
    let userId: Int
    let nickname: String
}
