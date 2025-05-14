//
//  UserSession.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//



final class UserSession {
    static let shared = UserSession()
    private init() {}

    var userId: Int?
    var nickname: String?
    var isLoggedIn: Bool {
        return userId != nil
    }

    func clear() {
        userId = nil
        nickname = nil
    }
}
