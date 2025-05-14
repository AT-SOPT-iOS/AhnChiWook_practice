//
//  NetworkError.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//


enum NetworkError: Int, Error, CustomStringConvertible {
    case requestEncodingError
    case responseDecodingError
    case responseError
    case unknownError
    case loginFailed = 400
    case internalServerError = 500
    case notFoundError = 404
    case emptyNickname
    case invalidNicknameFormat

    var description: String {
        switch self {
        case .loginFailed: return "로그인에 실패하였습니다."
        case .requestEncodingError: return "요청 인코딩에 실패했습니다."
        case .responseError: return "응답이 올바르지 않습니다."
        case .responseDecodingError: return "서버 응답을 해석하지 못했습니다."
        case .unknownError: return "알 수 없는 오류가 발생했습니다."
        case .internalServerError: return "서버 오류가 발생했습니다."
        case .notFoundError: return "해당 유저를 찾을 수 없습니다."
        case .emptyNickname: return "닉네임을 입력해주세요."
        case .invalidNicknameFormat: return "닉네임은 한글/영문/숫자 1~20자로 입력해야 합니다."
        }
    }
}
