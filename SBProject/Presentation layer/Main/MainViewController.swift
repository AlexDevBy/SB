//
//  MainViewController.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    let cellId = "cell"
    let settingsVC: UIViewController = SettingsViewController()
    let questionVC: UIViewController = QuestionViewControlle()
    
    var buttonTapped: (() -> Void)?
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settingsButton"), for: .normal)
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelContainer: UIView = {
        let label = UIView()
        let back = UIImageView()
        let dice = UIImageView()
        let takeAChance = UILabel()
        let yesNo = UILabel()
        
        dice.image = UIImage(named: "dice")
        back.image = UIImage(named: "diceBack")
        
        takeAChance.font = AppFont.markProFont(ofSize: 18, weight: .bold)
        takeAChance.text = "Take a chance"
        takeAChance.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        yesNo.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        yesNo.font = AppFont.markProFont(ofSize: 12, weight: .regular)
        yesNo.numberOfLines = 0
        yesNo.lineBreakMode = .byWordWrapping
        yesNo.text = "Get the rates\nof yes and no"
        
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.5 // set your desired line height
        
        
        let text = "Get the rates\nof yes and no"

        
        
        let attributedString = NSMutableAttributedString(string: yesNo.text!)
        let yesRange = (text as NSString).range(of: "yes")
        let noRange = (text as NSString).range(of: "no")
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 12), range: yesRange)
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 12), range: noRange)
        yesNo.attributedText = attributedString
        
        label.addSubview(back)
        label.addSubview(dice)
        label.addSubview(takeAChance)
        label.addSubview(yesNo)
        
        back.snp.makeConstraints { make in
            make.top.equalTo(label.snp.top).offset(12)
            make.bottom.equalTo(label.snp.bottom).offset(-6)
            make.right.equalTo(label.snp.right)
            make.left.equalTo(label.snp.left)
        }
        
        takeAChance.snp.makeConstraints { make in
            make.top.equalTo(back.snp.top).offset(23)
            make.bottom.equalTo(back.snp.bottom).offset(-55)
            make.left.equalTo(back.snp.left).offset(20.44)
        }
        
        yesNo.snp.makeConstraints { make in
            make.top.equalTo(takeAChance.snp.bottom).offset(2)
            make.bottom.equalTo(back.snp.bottom).offset(-22)
            make.left.equalTo(takeAChance.snp.left)
        }
        
        dice.snp.makeConstraints { make in
            make.top.equalTo(label.snp.top)
            make.bottom.equalTo(label.snp.bottom)
            make.right.equalTo(label.snp.right).offset(-5.56)
            make.left.equalTo(label.snp.left).offset(147.44)
        }
        return label
    }()
    
    
//    var scrollView: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.backgroundColor = .clear
//        return scroll
//    }()
    
    let nutsView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "nuts")
        view.isHidden = true
        return view
    }()
    
    var nutsText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = AppFont.markProFont(ofSize: 16, weight: .bold)
        label.text = "Take a chance and give it a try"
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    private var collectionView: UICollectionView!
    
    
    let gradientView: UIView = {
        let view = UIView()
        
        let layer = CAGradientLayer()
        layer.colors = [ UIColor(red: 0.247, green: 0.725, blue: 1, alpha: 1).cgColor,
                         UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1))
        layer.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer.position = view.center
        view.layer.addSublayer(layer)
        return view
    }()
    
    var assessButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(assessTapped), for: .touchUpInside)
        button.setTitle("Assess the chance", for: .normal)
        button.backgroundColor = UIColor(hexString: "#262F68")
        return button
    }()
    
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        
        let questionContainer = Manager.shared.loadQuestionArray()
        self.questions = questionContainer
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 271, height: 77)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.reloadData()
        
        setupUI()
        chekForEmptyCV()
    }
    
    //    override func viewDidLayoutSubviews() {
    //        CollectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
    //            layout.itemSize = hdCollectionView.frame.size
    //            layout.minimumLineSpacing = 0
    //        }
    //        if let layout = thumbnailCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
    //            layout.itemSize = CGSize(width: 30, height: thumbnailCollectionView.frame.size.height)
    //            layout.minimumLineSpacing = 2
    //        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let questionContainer = Manager.shared.loadQuestionArray()
        self.questions = questionContainer
        chekForEmptyCV()
        collectionView.reloadData()
    
    }
    
    @objc func assessTapped() {
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    @objc func settingsTapped() {
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func chekForEmptyCV() {
        if questions.count == 0 {
            self.collectionView.isHidden = true
            self.nutsView.isHidden = false
            self.nutsText.isHidden = false
        } else {
            self.collectionView.isHidden = false
            self.nutsView.isHidden = true
            self.nutsText.isHidden = true
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("in here\(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCollectionViewCell
        cell.configure(with: questions[indexPath.row])
        cell.isSelected = false
        cell.isHighlighted = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 271, height: 77)
    }
    
    
    private func setupUI() {
        
        view.addSubview(settingButton)
        view.addSubview(labelContainer)
        view.addSubview(nutsView)
        view.addSubview(nutsText)
        view.addSubview(collectionView)
        //        scrollView.addSubview(collectionView)
        view.addSubview(gradientView)
        gradientView.addSubview(assessButton)
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(59)
            make.left.equalTo(view.snp.left).offset(37)
            make.width.equalTo(100)
            make.height.equalTo(18)
        }
        
        labelContainer.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom).offset(63)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(271)
            make.height.equalTo(118)
        }
        
//        scrollView.snp.makeConstraints { make in
//            make.left.equalTo(labelContainer.snp.left)
//            make.right.equalTo(labelContainer.snp.right)
//            make.top.equalTo(labelContainer.snp.bottom).offset(17)
//            make.bottom.equalTo(view.snp.bottom)
//        }
        
        nutsView.snp.makeConstraints { make in
            make.top.equalTo(labelContainer.snp.bottom).offset(79)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(170.04)
            make.height.equalTo(163.3)
            
        }
        
        nutsText.snp.makeConstraints { make in
            make.top.equalTo(nutsView.snp.bottom).offset(27.7)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(255)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(labelContainer.snp.left)
            make.right.equalTo(labelContainer.snp.right)
            make.top.equalTo(labelContainer.snp.bottom).offset(17)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        
        gradientView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.bottom).offset(-196)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        assessButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-62)
            make.height.equalTo(60)
            make.width.equalTo(271)
        }
        
    }
    
    
}

