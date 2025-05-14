//
//  LoginViewController.swift
//  week4
//
//  Created by 안치욱 on 5/3/25.
//

import UIKit
import Then
import SnapKit

final class APISignUpViewController: UIViewController {


    private var loginId: String = ""
    private var password: String = ""
    private var nickName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        // 1) UI 초기화
        idTextField.text = ""
        passwordTextField.text = ""
        nickNameTextField.text = ""
        // 2) 내부 변수도 초기화
        loginId = ""
        password = ""
    }
    
    @objc private func infoViewButtonTap() {
       let infoVC = InfoViewController()
       self.present(infoVC, animated: true)
    }
    
    @objc private func loginButtonTap() {
        let loginVC = APILoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    @objc private func textFieldDidEditing(_ textField: UITextField) {
        switch textField {
        case idTextField:
            loginId = textField.text ?? ""
        case passwordTextField:
            password = textField.text ?? ""
        default:
            nickName = textField.text ?? ""
        }
    }
    
    @objc private func registerButtonTap() {
        Task {
            do {
                let response = try await RegisterService.shared.PostRegisterData(loginId: self.loginId,
                                                                                 password: self.password,
                                                                                 nickName: self.nickName)
                let alert = UIAlertController(
                    title: "계정 생성 성공!!!!!",
                    message: "환영합니다~, \(response.nickname)님! (ID: \(response.userId)",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            catch {
                let alert = UIAlertController(
                    title: "계정 생성 실패.. T^T",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
                print("회원가입 에러: ", error)
            }
        }
    }
    
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }
        
        [idTextField, passwordTextField, nickNameTextField, registerButton, infoViewButton, loginButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        idTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        nickNameTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }
    }
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }
    
    private lazy var idTextField = UITextField().then {
        $0.addTarget(self,
                     action: #selector(textFieldDidEditing(_:)),
                     for: .allEvents)
        $0.backgroundColor = .lightGray
        $0.addLeftPadding()
        $0.layer.cornerRadius = 8
        $0.placeholder = "아이디를 입력하슈"
        $0.autocapitalizationType = .none
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.addTarget(self,
                     action: #selector(textFieldDidEditing(_:)),
                     for: .allEvents)
        $0.backgroundColor = .lightGray
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
        $0.layer.cornerRadius = 8
        $0.placeholder = "패스워드를 입력하슈"
        $0.autocapitalizationType = .none
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.addTarget(self,
                     action: #selector(textFieldDidEditing(_:)),
                     for: .allEvents)
        $0.backgroundColor = .lightGray
        $0.addLeftPadding()
        $0.layer.cornerRadius = 8
        $0.placeholder = "닉네임을 입력하슈"
        $0.autocapitalizationType = .none
    }
    
    private lazy var registerButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("회원가입", for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.textColor = .white
        $0.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
    }
    private lazy var infoViewButton = UIButton().then {
        $0.addTarget(self, action: #selector(infoViewButtonTap), for: .touchUpInside)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 8
        $0.setTitle("회원정보 조회", for: .normal)
        $0.titleLabel?.textColor = .white
    }
    private lazy var loginButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("로그인하러 가기", for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.textColor = .white
        $0.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
    }
}


