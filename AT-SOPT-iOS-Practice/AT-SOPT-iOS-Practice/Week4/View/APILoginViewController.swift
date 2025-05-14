//
//  APILoginViewController.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//

import UIKit
import SnapKit
import Then

final class APILoginViewController: UIViewController {
    
    private var loginId: String = ""
    private var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
        // 1) UI 초기화
        idTextField.text = ""
        passwordTextField.text = ""
        // 2) 내부 변수도 초기화
        loginId = ""
        password = ""
    }

    
    @objc private func textFieldDidEditing(_ textField: UITextField) {
        switch textField {
        case idTextField:
            loginId = textField.text ?? ""
        default:
            password = textField.text ?? ""
        }
    }
    @objc private func loginButtonTap() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let userData = try await AuthService.shared.login(
                    username: self.loginId,
                    password: self.password
                )
                UserSession.shared.userId = userData.userId

                let nickname = try await NicknameService.shared.fetchNickname(
                    for: userData.userId
                )
                UserSession.shared.nickname = nickname

                let welcomeVC = APIWelcomeViewController(userId: userData.userId)
                self.navigationController?.pushViewController(welcomeVC, animated: true)

            } catch let error as NetworkError {
                self.presentLoginFailedAlert(message: error.description)
            } catch {
                self.presentLoginFailedAlert(message: "알 수 없는 에러가 발생했습니다.")
            }
        }
    }
    @objc private func signupButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }
        
        [idTextField, passwordTextField, loginButton, signupButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        idTextField.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        signupButton.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
    }
    
    private func presentLoginFailedAlert(message: String) {
        let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "다시 로그인", style: .cancel)
        
        let signUpAction = UIAlertAction(title: "회원가입하러 가기", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(retryAction)
        alert.addAction(signUpAction)
        
        self.present(alert, animated: true)
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
        $0.placeholder = "아이디를 입력하소"
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
        $0.placeholder = "패스워드를 입력하소"
        $0.autocapitalizationType = .none
    }
    private lazy var loginButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("로그인하겠소", for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.textColor = .white
        $0.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
    }
    private lazy var signupButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("회원가입하러 가겠소", for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.textColor = .white
        $0.addTarget(self, action: #selector(signupButtonTap), for: .touchUpInside)
    }
}
