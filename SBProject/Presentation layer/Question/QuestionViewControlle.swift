//
//  QuestionViewControlle.swift
//  SB
//
//  Created by Alex Misko on 12.01.23.
//

import Foundation
import UIKit
import SnapKit

protocol PresenterDelegate {
    func popToPrevious()
}

class QuestionViewControlle: UIViewController, UITextViewDelegate, UITextFieldDelegate , PresenterDelegate {
    
    
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "nuts")
        return logo
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(hexString: "#7DC5FA")
        field.text = nil
        field.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        //        field.placeholder = "Type here your question..."
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        field.leftViewMode = .always
        field.leftView = spacerView
        
        field.attributedPlaceholder = NSAttributedString(
            string: "Type here your question...",
            attributes: [ NSAttributedString.Key.foregroundColor: UIColor.white,
              NSAttributedString.Key.font : AppFont.markProFont(ofSize: 15, weight: .bold) ]
        )
        return field
    }()
    
    let line: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 271, height: 0)
        label.backgroundColor = .white
        
        var stroke = UIView()
        stroke.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = label.center
        label.addSubview(stroke)
        label.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0.145, green: 0.184, blue: 0.424, alpha: 1).cgColor
        return label
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "The response will be either yes or no"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Please be aware that each question is reviewed by our team manually, the process may take up to 24 hours for the review to be completed."
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "Please keep in mind that the answers generated by the app are completely random and should not be considered as advice. Our application is intended for entertainment purposes only."
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
 
    
    let line2: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 271, height: 0)
        label.backgroundColor = .white
        
        var stroke = UIView()
        stroke.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = label.center
        label.addSubview(stroke)
        label.bounds = label.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0.145, green: 0.184, blue: 0.424, alpha: 1).cgColor
        return label
    }()
    
    let privacyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accessButtonTapped"), for:.normal);
        button.setImage(UIImage(named: "accessButtonTapped"), for:.highlighted)
        button.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    let guideButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accessButtonTapped"), for: .normal)
        button.setImage(UIImage(named: "accessButtonTapped"), for:.highlighted)
        button.addTarget(self, action: #selector(guideTapped), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    var isOn: Bool = false
    var isOn2: Bool = false
    
    
    let privacyLabel: UITextView = {
        let label = UITextView()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.font = AppFont.markProFont(ofSize: 10, weight: .medium)
        let text = "I consent to the Privacy Policy \nand Terms of Service."
        let attributedString = NSMutableAttributedString(string: "I consent to the Privacy Policy \nand Terms of Service.")
        attributedString.addAttribute(.link, value: "https://startingapp.website/privacy.html", range: NSRange(location: 17, length: 14))
        attributedString.addAttribute(.link, value: "https://startingapp.website/terms.html", range: NSRange(location: 37, length: 16))
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 17, length: 14))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 17, length: 14))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 37, length: 16))
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        label.isEditable = false
        return label
    }()
    
    let guideLabel: UITextView = {
        let label = UITextView()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.font = AppFont.markProFont(ofSize: 10, weight: .medium)
        let text = "I abide by the user-generated content \nguidelines of the terms of service."
        let attributedString = NSMutableAttributedString(string: "I abide by the user-generated content \nguidelines of the terms of service.")
        attributedString.addAttribute(.link, value: "https://startingapp.website", range: NSRange(location: 11, length: 38))
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 11, length: 38))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 17, length: 14))
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        label.isEditable = false
        return label
    }()
    
    let beginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(beginTapped), for: .touchUpInside)
        button.setTitle("Begin", for: .normal)
        button.titleLabel?.font = AppFont.markProFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(hexString: "#626376")
        button.isEnabled = false
        return button
    }()
    
    var questions: [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        setupUi()
        textField.delegate = self
        initializeHideKeyboard()
        var questionContainer = Manager.shared.loadQuestionArray()
        self.questions = questionContainer
    }

    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
        }
    
    @objc func beginTapped() {
        
        let final = FinalViewController()
        final.presenterDelegate = self
        let question = Question()
        guard let textFieldText = self.textField.text else { return }
        question.question = textFieldText
        question.yes = Double.random(in: 1...9)
        question.no = 10.0 - question.yes
        Manager.shared.addQuestionArray(question)
        
        let roundedValue1 = String(format: "%.2f", question.yes)
        let roundedValue2 = String(format: "%.2f", question.no)
        final.questionLabel.text = "\(question.question)"
        final.blueScore.text = "\(roundedValue1)"
        final.redScore.text = "\(roundedValue2)"
        final.blueView.tag = Int(question.yes)
        final.redView.tag = Int(question.no)
        
        self.navigationController?.pushViewController(final, animated: true)
    }
    
    @objc func privacyTapped(_ sender: UIButton) {
        isOn.toggle()
        
        setButtonBackGround(view: sender, on:  UIImage(imageLiteralResourceName: "accessButton"), off:  UIImage(imageLiteralResourceName: "accessButtonTapped"), onOffStatus: isOn)
    }
    
    @objc func guideTapped(_ sender: UIButton) {
        isOn2.toggle()
        
        setButtonBackGround(view: sender, on:  UIImage(imageLiteralResourceName: "accessButton"), off:  UIImage(imageLiteralResourceName: "accessButtonTapped"), onOffStatus: isOn2)
    }
    
    func setButtonBackGround(view: UIButton, on: UIImage, off: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            view.setImage(on, for: .normal)
            view.tag = 2
            print("Button Pressed")
        default:
            view.setImage(off, for: .normal)
            view.tag = 1
            print("Button Unpressed")
        }
        checkForBegin()
        
    }
    
    func checkForBegin() {
        if privacyButton.tag == 1 && guideButton.tag == 1 && ((textField.text?.isEmpty) != nil) == true {
            beginButton.backgroundColor = UIColor(hexString: "#252F6C")
            beginButton.isEnabled = true
        } else {
            beginButton.backgroundColor = UIColor(hexString: "#626376")
            beginButton.isEnabled = false
        }
        
        if textField.text!.isEmpty{
            beginButton.backgroundColor = UIColor(hexString: "#626376")
            beginButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            beginButton.backgroundColor = UIColor(hexString: "#252F6C")
            beginButton.isEnabled = true
        } else {
            beginButton.backgroundColor = UIColor(hexString: "#626376")
            beginButton.isEnabled = false
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL)
            return false
        }
    
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func updateTextView(descrLabel: UITextView, path: String, link: String) {
       // let path = "http://mail.ru"
        let text = descrLabel.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: link)
        
        descrLabel.attributedText = attributedString
        
    }
    
    
    
    
    
    func setupUi() {
        
        view.addSubview(backButton)
        view.addSubview(logoImageView)
        view.addSubview(textField)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(line)
        view.addSubview(line2)
        view.addSubview(privacyButton)
        view.addSubview(privacyLabel)
        view.addSubview(guideButton)
        view.addSubview(guideLabel)
        view.addSubview(beginButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(52)
            make.left.equalTo(view.snp.left).offset(30)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(170.04)
            make.height.equalTo(163.3)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(41.7)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(60)
            make.width.equalTo(271)
        }
        
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(18)
            make.left.equalTo(textField.snp.left)
            make.height.equalTo(12)
            make.width.equalTo(271)
        }
        
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(5)
            make.left.equalTo(label1.snp.left)
            make.height.equalTo(36)
            make.width.equalTo(271)
        }
        
        label3.snp.makeConstraints { (make) in
            make.top.equalTo(label2.snp.bottom).offset(5)
            make.left.equalTo(label2.snp.left)
            make.height.equalTo(48)
            make.width.equalTo(271)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom)
            make.left.equalTo(textField.snp.left)
            make.width.equalTo(271)
        }
        
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(label3.snp.bottom).offset(18)
            make.left.equalTo(label3.snp.left)
            make.width.equalTo(271)
        }
        
        privacyButton.snp.makeConstraints { (make) in
            make.top.equalTo(label3.snp.bottom).offset(101)
            make.left.equalTo(label3.snp.left).offset(2.44)
            make.width.height.equalTo(14)
        }
        
        privacyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(privacyButton.snp.centerY)
            make.left.equalTo(privacyButton.snp.right).offset(15.56)
            make.height.equalTo(42)
            make.width.equalTo(241)
        }
        
        guideButton.snp.makeConstraints { (make) in
            make.top.equalTo(label3.snp.bottom).offset(143)
            make.left.equalTo(label3.snp.left).offset(2.44)
            make.width.height.equalTo(14)
        }
        
        guideLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(guideButton.snp.centerY)
            make.left.equalTo(guideButton.snp.right).offset(15.56)
            make.height.equalTo(42)
            make.width.equalTo(241)
        }
        
        beginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-62)
            make.height.equalTo(60)
            make.width.equalTo(271)
        }
    }
}
