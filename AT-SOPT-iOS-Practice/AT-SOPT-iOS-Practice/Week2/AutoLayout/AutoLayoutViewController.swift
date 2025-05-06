//
//  AutoLayoutViewController.swift
//  AT-SOPT-iOS-Practice
//
//  Created by 안치욱 on 4/20/25.
//

import UIKit

class AutoLayoutViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPurple
        setLayout()
    }
    
//    private func setLayout() {
//        [바둑알1, 바둑알2, 방어막].forEach {
//        self.view.addSubview($0)
//       $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        NSLayoutConstraint.activate([바둑알1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
//                                     바둑알1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
//                                     바둑알1.widthAnchor.constraint(equalToConstant: 20),
//                                     바둑알1.heightAnchor.constraint(equalToConstant: 20)])
//
//        NSLayoutConstraint.activate([바둑알2.topAnchor.constraint(equalTo: self.바둑알1.bottomAnchor, constant: 40),
//                                     바둑알2.leadingAnchor.constraint(equalTo: self.바둑알1.trailingAnchor, constant: 40),
//                                     바둑알2.widthAnchor.constraint(equalToConstant: 20),
//                                     바둑알2.heightAnchor.constraint(equalToConstant: 20)])
//
//        NSLayoutConstraint.activate([방어막.leadingAnchor.constraint(equalTo: 바둑알2.trailingAnchor, constant: 20),
//                                     방어막.topAnchor.constraint(equalTo: 바둑알2.bottomAnchor, constant: 20),
//                                     방어막.widthAnchor.constraint(equalToConstant: 60),
//                                     방어막.heightAnchor.constraint(equalToConstant: 10)])
//
//
//    }
    private func setLayout()
    {
        let height = UIScreen.main.bounds.height / 4
        let width = UIScreen.main.bounds.width / 2
//        view.addSubviews(
//            sq1,
//            sq2,
//            sq3,
//            sq4
//        )
//        view.translatesAutoresizingMaskIntoConstraints = false
        [sq1, sq2, sq3, sq4].forEach{ view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([sq1.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     sq1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     sq1.widthAnchor.constraint(equalToConstant: width),
                                     sq1.heightAnchor.constraint(equalToConstant: height)])
        NSLayoutConstraint.activate([sq2.topAnchor.constraint(equalTo: sq1.bottomAnchor),
                                     sq2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     sq2.widthAnchor.constraint(equalToConstant: width),
                                     sq2.heightAnchor.constraint(equalToConstant: height)])
        NSLayoutConstraint.activate([sq3.topAnchor.constraint(equalTo: sq2.bottomAnchor),
                                     sq3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     sq3.widthAnchor.constraint(equalToConstant: width),
                                     sq3.heightAnchor.constraint(equalToConstant: height)])
        NSLayoutConstraint.activate([sq4.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     sq4.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     sq4.widthAnchor.constraint(equalToConstant: width),
                                     sq4.heightAnchor.constraint(equalToConstant: height)])
        
    }
    
    var sq1 : UIView =
    {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var sq2 : UIView =
    {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var sq3 : UIView =
    {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var sq4 : UIView =
    {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var 바둑알1: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 20,
                                                                  height: 20)))
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var 바둑알2: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 20,
                                                                 height: 20)))
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    var 방어막: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
}
