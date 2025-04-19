//
//  loginViewController_Delegate.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 4/20/25.
//

import UIKit

class LoginViewController_Delegate: UIViewController, DataBindDelegate {
    
    private let imageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 128, y: 130, width: 150, height: 150))
        imageview.image = UIImage(named: "icon.png")
        return imageview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 32, y: 281, width: 335, height: 80))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .pretendard(.semiBold, size: 20) //label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        //label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 32, y: 396, width: 335, height: 52))
        textField.placeholder = "아이디"
        textField.setPlaceholderColor(.darkGray)
        textField.layer.cornerRadius = 8
        textField.addLeftPadding()
        textField.clearButtonMode = .always
        textField.textColor = .black
        //textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.font = .pretendard(.semiBold, size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 32, y: 455, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.setPlaceholderColor(.darkGray)
        textField.layer.cornerRadius = 8
        textField.addLeftPadding()
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.textColor = .black
        //textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.font = .pretendard(.semiBold, size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 32, y: 542, width: 332, height: 58))
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 24)
        button.titleLabel?.font = .pretendard(.black, size: 24)
        button.addTarget(self, action: #selector(LoginViewController_Delegate.loginButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func loginButtonDidTapped() {
        pushToWelcome()
        //presentToWelcomeVC()
    }
    
    func dataBind(id: String) {
        idTextField.text = id
        print("\(id)")
    }
    
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .formSheet
        self.present(welcomeViewController, animated: true)
    }
    
    private func pushToWelcome() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.id = idTextField.text
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        //loginBtnEnable()
    }
    
    private func setLayout() {
        view.addSubviews(
            imageView,
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton
        )
    }
    // - TODO:  구현해야하는 함수
    private func loginBtnEnable()
    {
        //        if(!(idTextField.text ?? "").isEmpty || !(passwordTextField.text ?? "").isEmpty)
        //        {
        //            loginButton.isEnabled = true
        //        }
        //        else
        //        {
        //            loginButton.isEnabled = false
        //        }
    }
}
