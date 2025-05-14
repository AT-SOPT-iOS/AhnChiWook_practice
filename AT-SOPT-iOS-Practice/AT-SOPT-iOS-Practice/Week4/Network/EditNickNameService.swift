//
//  EditNiackNameService.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//

import UIKit

final class EditNickNameService {
    static let shared = EditNickNameService()
    private init() {}

    func updateNickname(to newNickname: String) async throws {
        guard let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/users") else {
            throw NetworkError.unknownError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let userId = UserSession.shared.userId else {
            throw NetworkError.unknownError
        }
        request.setValue("\(userId)", forHTTPHeaderField: "userId")

        let body = ["nickname": newNickname]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw NetworkError.responseError
        }
    }
}
