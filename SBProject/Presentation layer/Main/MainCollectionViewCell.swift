//
//  MainCollectionViewCell.swift
//  SB
//
//  Created by Alex Misko on 12.01.23.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red: 0.002, green: 0.636, blue: 1, alpha: 1).cgColor
        return label
    }()
    
    let YesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red: 0.145, green: 0.184, blue: 0.424, alpha: 1).cgColor
        return label
    }()
    
    let NoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = UIColor(red: 0.918, green: 0.114, blue: 0.145, alpha: 1).cgColor
        return label
    }()
    
    let cellId = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    func configure(with model: Question) {
//        guard model.question != nil else { return }
//        guard model.yes != nil else { return }
//        guard model.no != nil else { return }
        
        self.questionLabel.text = "\(String(model.question))"
        self.YesLabel.text = "\(String(format: "%.2f", model.yes))"
        self.NoLabel.text = "\(String(format: "%.2f", model.no))"

    }
    
    
    func addViews(){

        addSubview(questionLabel)
        addSubview(YesLabel)
        addSubview(NoLabel)
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        
        YesLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalTo(questionLabel.snp.centerX)
            make.bottom.equalToSuperview()
        }
        
        NoLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom)
            make.left.equalTo(questionLabel.snp.centerX)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
