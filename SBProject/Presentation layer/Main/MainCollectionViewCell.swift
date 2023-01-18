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
    
    let cellId = "cell"
    
    var heightOfCell: CGFloat = 0.0 {
        
        didSet {
            print(heightOfCell)
           
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
         let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
         label.numberOfLines = 0
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         label.font = font
         label.text = text

         label.sizeToFit()
         return label.frame.height
     }
    
  
    
    func configure(with model: Question) {
//        guard model.question != nil else { return }
//        guard model.yes != nil else { return }
//        guard model.no != nil else { return }
        self.heightOfCell = heightForView(text: "\(String(model.question))", font: self.questionLabel.font, width: 271)
        
        self.questionLabel.text = "\(String(model.question))"
        self.YesLabel.text = "\(String(format: "%.2f", model.yes))"
        self.NoLabel.text = "\(String(format: "%.2f", model.no))"
        
        

    }
    
//    func setText(_ text: String) {
//            label.text = text
//            // Determine the size of the cell based on the text entered
//            let size = determineSize(for: text)
//            // Update the layout of the cell with the new size
//            updateLayout(with: size)
//        }
    
    
    func addViews(){

        addSubview(questionLabel)
        addSubview(YesLabel)
        addSubview(NoLabel)
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
                    }
        
        YesLabel.snp.makeConstraints { make in
           
            make.left.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
        
        NoLabel.snp.makeConstraints { make in
           
            make.height.equalTo(24)
            make.right.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
