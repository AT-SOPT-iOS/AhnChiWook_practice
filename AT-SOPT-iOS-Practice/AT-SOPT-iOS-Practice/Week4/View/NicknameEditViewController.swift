//
//  NicknameEditViewController.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 5/14/25.
//


import UIKit
import SnapKit
import Then

final class NicknameEditViewController: UIViewController {
    
    // MARK: - Properties
    
    private let currentNickname: String
    /// 모달 닫힐 때 새 닉네임을 리턴하는 클로저
    var onComplete: ((String?) -> Void)?
    
    // MARK: - UI
    
    private let textField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "새 닉네임을 입력하세요"
    }
    
    private let saveButton = UIButton(type: .system).then {
        $0.setTitle("수정", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    // MARK: - Init
    
    init(currentNickname: String) {
        self.currentNickname = currentNickname
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        
        // 현재 닉네임 미리 채워두기
        textField.text = currentNickname
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func saveTapped() {
        let newNickname = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !newNickname.isEmpty else {
            showErrorAlert(message: "닉네임을 입력해주세요.")
            return
        }
        
        // PATCH 요청
        Task { [weak self] in
            guard let self = self else { return }
            do {
                try await EditNickNameService.shared.updateNickname(to: newNickname)
                // 성공하면 클로저로 리턴하고 모달 닫기
                self.onComplete?(newNickname)
            } catch let error as NetworkError {
                self.showErrorAlert(message: error.description)
            } catch {
                self.showErrorAlert(message: "알 수 없는 오류가 발생했습니다.")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubviews(textField, saveButton)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(100)
        }
    }
}
