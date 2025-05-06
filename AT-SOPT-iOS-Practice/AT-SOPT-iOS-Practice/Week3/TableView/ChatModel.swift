//
//  ChatModel.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/6/25.
//


import UIKit

struct ChatModel {
    let profileImg: UIImage
    let name: String
    let place: String
    let message: String
    let itemImg: UIImage
}


extension ChatModel {
    static func dummy() -> [ChatModel] {
        return [
            ChatModel(profileImg: .image73, name: "김가현", place: "광진구", message: "내말에답장해줘", itemImg: .image77),
            ChatModel(profileImg: .image75, name: "김현수", place: "여의도", message: "마크내사랑", itemImg: .image124),
            ChatModel(profileImg: .image135, name: "서주영", place: "잠실", message: "마크내꺼", itemImg: .image125),
            ChatModel(profileImg: .image133, name: "권석기", place: "회기", message: "나는 민경훈", itemImg: .image127),
            ChatModel(profileImg: .image78, name: "김나연", place: "미국", message: "타코팔러가야돼", itemImg: .image128),
            ChatModel(profileImg: .frame51, name: "정정욱", place: "중국", message: "보쌈정식13000원", itemImg: .image126),
            ChatModel(profileImg: .image135, name: "서상원", place: "일본", message: "잠실의주인은두산이다", itemImg: .image129),
            ChatModel(profileImg: .image135, name: "임재현", place: "태국", message: "뒷풀이갈게", itemImg: .image130),
            ChatModel(profileImg: .image78, name: "이은지", place: "명왕성", message: "은지야술먹자", itemImg: .image131),
            ChatModel(profileImg: .image135, name: "성현주", place: "안드로메다", message: "응애~", itemImg: .image126),
            ChatModel(profileImg: .frame51, name: "김한열", place: "뭘보슈", message: "생일추카해한열오빠", itemImg: .image124)
        ]
    }
}