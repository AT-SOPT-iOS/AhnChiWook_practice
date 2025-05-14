//
//  APIWelcomeViewController.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//

import UIKit
import SnapKit
import Then

final class APIWelcomeViewController: UIViewController {
    
    private let userId: Int
    private var nickname: String? {
        didSet {
            welcomeLabel.text = "환영합니다, \(nickname ?? "")님!"
        }
    }

    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        // 세션에 저장된 닉네임을 바로 표시
        self.nickname = UserSession.shared.nickname
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }

    // MARK: - Actions

    @objc private func nicknameChangeButtonTap() {
        let current = nickname ?? ""
        Task { [weak self] in
            guard let self = self else { return }
            do {
                if let newNickname = try await presentNicknameEditModal(current: current) {
                    try await EditNickNameService.shared.updateNickname(to: newNickname)
                    UserSession.shared.nickname = newNickname
                    self.nickname = newNickname
                }
            } catch let error as NetworkError {
                self.showErrorAlert(message: error.description)
            } catch {
                self.showErrorAlert(message: "알 수 없는 에러가 발생했습니다.")
            }
        }
    }
    @objc private func logoutButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Modal Presentation

    private func presentNicknameEditModal(current: String) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            let editVC = NicknameEditViewController(currentNickname: current)
            editVC.onComplete = { result in
                self.dismiss(animated: true)
                continuation.resume(returning: result)
            }
            if let sheet = editVC.sheetPresentationController {
                sheet.detents = [UISheetPresentationController.Detent.medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(editVC, animated: true)
        }
    }

    // MARK: - Error Alert

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Layout

    private func setLayout() {
        view.addSubviews(welcomeLabel, nickChangeButton, logoutButton)
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
        }
        nickChangeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(55)
            $0.height.equalTo(44)
        }
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(85)
            $0.leading.trailing.equalToSuperview().inset(55)
            $0.height.equalTo(44)
        }
    }

    // MARK: - Views

    private lazy var welcomeLabel = UILabel().then {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
    }

    private lazy var nickChangeButton = UIButton().then {
        $0.setTitle("닉네임 바꾸기", for: .normal)
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(nicknameChangeButtonTap), for: .touchUpInside)
    }
    
    private lazy var logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
    }
}
