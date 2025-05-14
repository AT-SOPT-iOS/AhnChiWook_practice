//
//  ItemCollectionViewCell.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/6/25.
//


import UIKit
import SnapKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ItemCollectionViewCell"
    
    var itemRow: Int?
    
    private let itemImageView = UIImageView()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(.heart, for: .normal)
        button.setImage(.heartFilled, for: .selected)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        [itemImageView, productNameLabel, productPriceLabel, heartButton].forEach {
            contentView.addSubview($0)
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(59)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(9)
        }
        
        productPriceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(9)
        }
        
        heartButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(itemImageView).inset(8)
            $0.size.equalTo(16)
        }
    }
    
}


extension ItemCollectionViewCell {
    
    func dataBind(_ itemData: ItemModel, itemRow: Int) {
       
        itemImageView.image = itemData.itemImg
        productNameLabel.text = itemData.name
        productPriceLabel.text = itemData.price
        //heartSelected = itemData.heartIsSelected
    }
}
