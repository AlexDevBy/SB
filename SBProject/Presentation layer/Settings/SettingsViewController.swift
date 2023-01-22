//
//  SettingsViewController.swift
//  SBProject
//
//  Created by Alex Misko on 12.01.23.
//

import Foundation
import SnapKit
import UIKit

class SettingsViewController: UIViewController {
    
    var backButtonTapped: (() -> Void)?

    
    var backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    var settingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 24, weight: .bold)
        label.text = "Settings"
        return label
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send feedback", for: .normal)
        button.titleLabel?.font = AppFont.markProFont(ofSize: 16, weight: .medium)
        button.tintColor = UIColor.white
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    let privacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy policy", for: .normal)
        button.titleLabel?.font = AppFont.markProFont(ofSize: 16, weight: .medium)
        button.tintColor = UIColor.white
        button.tag = 3
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    let termsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms and conditions", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = AppFont.markProFont(ofSize: 16, weight: .medium)
        button.tintColor = UIColor.white
        button.tag = 4
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)

        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(hexString: "#63B7F8")

    }

    @objc func buttonTap(sender: UIButton) {
        switch sender.tag {
        case 1:
            print(sender.tag)
//            backButtonTapped?()
            self.navigationController?.popViewController(animated: true)
        case 2:
            print(sender.tag)
            self.showWebView(url: "https://startingapp.website/content.html", title: "support")
        case 3:
            print(sender.tag)
            self.showWebView(url: "https://startingapp.website/privacy.html", title: "support")
        case 4:
            print(sender.tag)
            self.showWebView(url: "https://startingapp.website/terms.html", title: "support")
        default:
            print(sender.tag)
        }
    }
//https://startingapp.website
    
    func showWebView(url: String, title: String) {
        let web = WebViewController(site: url, title: title, withExitButton: true, withBackButton: true)
         self.present(web, animated: true)
    }
    
    func setupUI() {
        
        view.addSubview(backButton)
        view.addSubview(settingsLabel)
        view.addSubview(feedbackButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(52)
            make.left.equalTo(view.snp.left).offset(30)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(122)
            make.left.equalTo(view.snp.left).offset(50)
            make.height.equalTo(29)
        }
        
        feedbackButton.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(24)
            make.left.equalTo(settingsLabel.snp.left)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(feedbackButton.snp.bottom).offset(7)
            make.left.equalTo(settingsLabel.snp.left)
        }
        
        termsButton.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(7)
            make.left.equalTo(settingsLabel.snp.left)
        }
    }
}
