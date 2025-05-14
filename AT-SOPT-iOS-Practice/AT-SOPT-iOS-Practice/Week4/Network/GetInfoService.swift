//
//  GetInfoService.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//

import UIKit

final class GetInfoService {
    
    static let shared = GetInfoService()
    private init() {}
    
    func makeRequest(keyword: String?) -> URLRequest? {
        
        var urlString = "http://api.atsopt-seminar4.site/api/v1/users"
        
        if let keyword = keyword, !keyword.isEmpty,
           let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString += "?keyword=\(encoded)"
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // optional
        return request
    }
    
    func fetchNicknameKist(keyword: String?) async throws -> [String] {
        
        guard let request = makeRequest(keyword: keyword) else { throw NetworkError.requestEncodingError }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw NetworkError.responseError }
        
        do {
            let decoded = try JSONDecoder().decode(NicknameListResponseWrapper.self, from: data)
            return decoded.data.nicknameList
        }
        catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
    
}
