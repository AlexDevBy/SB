//
//  FinalViewController.swift
//  SB
//
//  Created by Alex Misko on 14.01.23.
//

import Foundation
import UIKit
import SnapKit


class FinalViewController: UIViewController {
    
    var presenterDelegate: PresenterDelegate? = nil
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let topLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .regular)
        label.text = "Your chances for question:"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let questionLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .bold)
        label.text = ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#252F6C")
        view.tag = Int(0.0)
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#EA3323")
        view.tag = Int(0.0)
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        return view
    }()
    
    let blueScore: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let redScore: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let yesLabel: UILabel = {
        let label = UILabel()
        label.text = "yes"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let noLabel: UILabel = {
        let label = UILabel()
        label.text = "no"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    let gotItButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(gotItTapped), for: .touchUpInside)
        button.setTitle("Got It!", for: .normal)
        button.backgroundColor = UIColor(hexString: "#252F6C")
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        setupUi()
        
//        view.layoutIfNeeded()
        
//        blueView.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.top).offset(Int(redView.tag))
//        }

//        UIView.animate(withDuration: 1.0, animations: {
//             self.view.layoutIfNeeded()
//        })
    }
    
    @objc func backTapped() {
            self.navigationController?.popViewController(animated: true)
        }
    
    @objc func gotItTapped() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.presenterDelegate?.popToPrevious()
        })
    }
    
    
    func setupUi() {
        
        view.addSubview(backButton)
        view.addSubview(topLabel)
        view.addSubview(questionLabel)
        view.addSubview(gotItButton)
        view.addSubview(lineView)
        view.addSubview(blueView)
        view.addSubview(redView)
        view.addSubview(blueScore)
        view.addSubview(redScore)
        view.addSubview(yesLabel)
        view.addSubview(noLabel)
        
        
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(52)
            make.left.equalTo(view.snp.left).offset(30)
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(90)
            make.height.equalTo(24)
            make.width.equalTo(271)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(topLabel.snp.bottom).offset(14)
            make.height.equalTo(48)
            make.width.equalTo(271)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(gotItButton.snp.top).offset(-109)
            make.left.equalTo(gotItButton.snp.left)
            make.width.equalTo(271)
        }
        
        blueView.snp.makeConstraints { make in
            make.bottom.equalTo(lineView.snp.top)
            make.left.equalTo(gotItButton.snp.left)
            make.width.equalTo(130)
            make.height.equalTo(40 * Int(blueView.tag))
        }
        
        redView.snp.makeConstraints { make in
            make.bottom.equalTo(lineView.snp.top)
            make.right.equalTo(gotItButton.snp.right)
            make.width.equalTo(130)
            make.height.equalTo(40 * Int(redView.tag))
        }
        
        blueScore.snp.makeConstraints { make in
            make.bottom.equalTo(gotItButton.snp.top).offset(-79)
            make.left.equalTo(gotItButton.snp.left)
            make.height.equalTo(24)
            make.width.equalTo(130)
        }
        
        redScore.snp.makeConstraints { make in
            make.bottom.equalTo(gotItButton.snp.top).offset(-79)
            make.right.equalTo(gotItButton.snp.right)
            make.height.equalTo(24)
            make.width.equalTo(130)
        }
        
        yesLabel.snp.makeConstraints { make in
            make.bottom.equalTo(gotItButton.snp.top).offset(-60)
            make.left.equalTo(gotItButton.snp.left)
            make.height.equalTo(24)
            make.width.equalTo(130)
        }
        
        noLabel.snp.makeConstraints { make in
            make.bottom.equalTo(gotItButton.snp.top).offset(-60)
            make.right.equalTo(gotItButton.snp.right)
            make.height.equalTo(24)
            make.width.equalTo(130)
        }
        
        gotItButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-62)
            make.height.equalTo(60)
            make.width.equalTo(271)
        }
    }
}
