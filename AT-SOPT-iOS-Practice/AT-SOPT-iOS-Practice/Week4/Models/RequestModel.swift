//
//  RequestModel.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//
import Foundation

struct RegisterRequestBody: Codable {
    let loginId: String
    let password: String
    let nickname: String
}
