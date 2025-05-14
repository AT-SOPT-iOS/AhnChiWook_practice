//
//  ItemViewController.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/6/25.
//


import UIKit
import SnapKit

class ItemViewController: UIViewController {

    private let itemData = ItemModel.dummy()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) // 개중요ㅕ 잊으면 안더ㅐㅁ
    
    final let carrotLineSpacing: CGFloat = 10
    final let carrotInterItemSpacing: CGFloat = 21
    final let cellHeight: CGFloat = 198
    final let carrotInset = UIEdgeInsets(top: 48, left: 20, bottom: 10, right: 20)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCollectionViewLayout()
        register()
        setDelegate()
        setStyle()
        setLayout()
    }
    
    private func calculateCellHeight() -> CGFloat {
        
        let count = CGFloat(itemData.count)
        let heightCount = count / 2 + count.truncatingRemainder(dividingBy: 2)
        return heightCount * cellHeight + (heightCount - 1) * carrotLineSpacing + carrotInset.top + carrotInset.bottom
    }

    // 얘도 개중요함 델리게이트 써도 댐
    private func setCollectionViewLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let doubleCellWidth = screenWidth - carrotInset.left - carrotInset.right - carrotInterItemSpacing
        
        flowLayout.itemSize = CGSize(width: doubleCellWidth/2, height: 198)
        flowLayout.minimumLineSpacing = carrotLineSpacing
        flowLayout.minimumInteritemSpacing = carrotInterItemSpacing
        self.collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    private func register() {
        
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    private func setDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setStyle() {
        
        collectionView.backgroundColor = .black
    }
    private func setLayout() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

//extension ItemViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = UIScreen.main.bounds.width
//        let doubleCellWidth = screenWidth - carrotInset.left - carrotInset.right - carrotInterItemSpacing
//        return CGSize(width: doubleCellWidth / 2, height: 198)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return carrotLineSpacing
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return carrotInterItemSpacing
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return carrotInset
//    }
//}

extension ItemViewController: UICollectionViewDelegate{
    
}

extension ItemViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(itemData[indexPath.item], itemRow: indexPath.row)
        return cell
    }
}