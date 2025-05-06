//
//  ItemModel.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/6/25.
//


import UIKit

struct ItemModel {
    let itemImg: UIImage
    let name: String
    let price: String
    var heartIsSelected: Bool
}

extension ItemModel {
    static func dummy() -> [ItemModel] {
        return [
            ItemModel(itemImg: .image126, name: "퉁퉁퉁사후르", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image77, name: "오쏘몰", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image126, name: "퉁퉁퉁 사후르", price: "5,000원", heartIsSelected: true),
            ItemModel(itemImg: .image135, name: "쿵야", price: "5,000원", heartIsSelected: true),
            ItemModel(itemImg: .image125, name: "헤드셋", price: "5,000원", heartIsSelected: true),
            ItemModel(itemImg: .image124, name: "틴트", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image127, name: "카메라", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image129, name: "로션", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image128, name: "락스", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image126, name: "가방", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image130, name: "헤드셋", price: "5,000원", heartIsSelected: false),
            ItemModel(itemImg: .image131, name: "틴트", price: "5,000원", heartIsSelected: false)
        ]
    }
}