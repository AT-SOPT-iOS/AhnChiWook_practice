//
//  WelcomeViewController.swift
//  week1
//
//  Created by 안치욱 on 4/5/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    var id: String?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 125, width: 300, height: 50))
        label.textColor = .white
        label.textAlignment = .center
        label.font = .pretendard(.semiBold, size: 22)
        return label
    }()
    
    private let reLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 35, y: 500, width: 335, height: 52))
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 8
        button.setTitle("다시 로그인하기", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 24)
        button.addTarget(self, action: #selector(ReloginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 128, y: 220, width: 150, height: 180))
        let image = UIImage(named: "carrot.jpg")
        imageview.image = image
        return imageview
    }()
    
//    private func popView()
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @objc
    private func ReloginButtonTapped()
    {
        self.imageView.image = UIImage(named: "carrot2.jpg")
        let logoutAlert = UIAlertController(title: "로그아웃", message: "다시 로그인 하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.imageView.image = UIImage(named: "carrot.jpg")
        }
        logoutAlert.addAction(okAction)
        logoutAlert.addAction(cancelAction)
        present(logoutAlert, animated: true)
//        popView()
    }
    
    private func bindID() {
        guard let id, !id.isEmpty else {
            self.welcomeLabel.text = "익명의 사용자님 반가워요!"
            return
        }
        self.welcomeLabel.text = "\(id)님 반가워요!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemOrange
        setLayout()
        bindID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    private func setLayout() {
//        [reLoginButton, imageView, welcomeLabel].forEach {
//            self.view.addSubview($0)
//        }
        view.addSubviews(
            reLoginButton,
            imageView,
            welcomeLabel)
    }
}
