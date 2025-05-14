//
//  AuthService.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//


import UIKit


final class AuthService {

    static let shared = AuthService()
    private init() {}

    func login(username: String, password: String) async throws -> UserData {
        guard let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/auth/signin") else {
            throw NetworkError.unknownError
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginData = LoginRequest(loginId: username, password: password)

        guard let httpBody = try? JSONEncoder().encode(loginData) else {
            throw NetworkError.requestEncodingError
        }

        request.httpBody = httpBody

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }

        do {
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            if decoded.success, let userData = decoded.data {
                UserSession.shared.userId = userData.userId
                return userData
            } else {
                switch decoded.code {
                case "USER_001":
                    throw NetworkError.loginFailed
                case "REQUEST_001":
                    if decoded.message.contains("아이디") {
                        throw NetworkError.notFoundError
                    } else if decoded.message.contains("비밀번호") {
                        throw NetworkError.loginFailed
                    } else {
                        throw NetworkError.unknownError
                    }
                default:
                    throw NetworkError.unknownError
                }
            }
        } catch {
            throw NetworkError.responseDecodingError
        }
    }

    private func configureHTTPError(errorCode: Int) -> NetworkError {
        return NetworkError(rawValue: errorCode) ?? .unknownError
    }
}
