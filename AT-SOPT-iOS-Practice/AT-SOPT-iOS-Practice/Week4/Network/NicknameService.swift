//
//  NicknameService.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//

import UIKit

final class NicknameService {
    static let shared = NicknameService()
    private init() {}

    /// GET /api/v1/user/nickname
    func fetchNickname(for userId: Int) async throws -> String {
        // 1) 올바른 URL
        guard let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/users/me") else {
            throw NetworkError.unknownError
        }
        var request = URLRequest(url: url)
        // 2) HTTP Method는 GET
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(userId)", forHTTPHeaderField: "userId")

        // 3) 네트워크 호출
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw NetworkError.responseError
        }

        // 4) JSON 디코딩
        let decoded = try JSONDecoder().decode(LoginNicknameResponse.self, from: data)
        guard decoded.success, let nickname = decoded.data?.nickname else {
            throw NetworkError.notFoundError
        }
        return nickname
    }
}
