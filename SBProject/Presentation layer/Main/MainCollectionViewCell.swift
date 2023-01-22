//
//  MainCollectionViewCell.swift
//  SBProject
//
//  Created by Alex Misko on 12.01.23.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let cellId = "cell"
    
    let questionLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#00A2FF")
        return view
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.backgroundColor = UIColor(hexString: "#00A2FF").cgColor
        label.numberOfLines = 0
        return label
    }()
    
    let YesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red: 0.145, green: 0.184, blue: 0.424, alpha: 1).cgColor
        label.textAlignment = .center
        return label
    }()
    
    let NoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red: 0.918, green: 0.114, blue: 0.145, alpha: 1).cgColor
        label.textAlignment = .center
        return label
    }()
    
    //    MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    //    MARK: configure
    func configure(with model: Question) {
        self.questionLabel.text = "\(String(model.question))"
        self.YesLabel.text = "\(String(format: "%.2f", model.yes))"
        self.NoLabel.text = "\(String(format: "%.2f", model.no))"
    }
    
    //    MARK: addViews
    func addViews(){
        
        addSubview(questionLabelContainer)
        questionLabelContainer.addSubview(questionLabel)
        questionLabelContainer.addSubview(YesLabel)
        questionLabelContainer.addSubview(NoLabel)
        
        
        questionLabelContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabelContainer.snp.top).offset(5)
            make.bottom.equalTo(YesLabel.snp.top).offset(-5)
            make.left.equalTo(questionLabelContainer.snp.left).offset(5)
            make.right.equalTo(questionLabelContainer.snp.right).offset(-5)
        }
        
        YesLabel.snp.makeConstraints { make in
            make.left.equalTo(questionLabelContainer.snp.left)
            make.bottom.equalTo(questionLabelContainer.snp.bottom)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(24)
        }
        
        NoLabel.snp.makeConstraints { make in
            make.right.equalTo(questionLabelContainer.snp.right)
            make.bottom.equalTo(questionLabelContainer.snp.bottom)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
