//
//  MainViewController.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//

import Foundation
import UIKit
import SnapKit



class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    let cellId = "cell"
    let settingsVC: UIViewController = SettingsViewController()
    let questionVC: UIViewController = QuestionViewControlle()
    var questions: [Question] = []
    var buttonTapped: (() -> Void)?
    //    private var collectionView: UICollectionView!

    
    
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
        takeAChance.backgroundColor = .clear
        
        
        yesNo.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        yesNo.font = AppFont.markProFont(ofSize: 12, weight: .regular)
        yesNo.numberOfLines = 0
        yesNo.lineBreakMode = .byWordWrapping
        yesNo.text = "Get the rates\nof yes and no"
        let text = "Get the rates\nof yes and no"
        let attributedString = NSMutableAttributedString(string: yesNo.text!)
        let yesRange = (text as NSString).range(of: "yes")
        let noRange = (text as NSString).range(of: "no")
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.markProFont(ofSize: 12, weight: .bold), range: yesRange)
        attributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.markProFont(ofSize: 12, weight: .bold), range: noRange)
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
            make.left.equalTo(back.snp.left).offset(20.44)
        }
        
        yesNo.snp.makeConstraints { make in
            make.top.equalTo(takeAChance.snp.bottom).offset(2)
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.contentMode = .center
        return collectionView
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        
        let layer = CAGradientLayer()
        layer.colors = [ UIColor(red: 0.247, green: 0.725, blue: 1, alpha: 1).cgColor,
                         UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
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
        button.titleLabel?.font = AppFont.markProFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(hexString: "#262F68")
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        let questionContainer = Manager.shared.loadQuestionArray()
        self.questions = questionContainer
        setupCollectionView()
        chekForEmptyCV()
        setupUI()
//        collectionView.reloadData()
    }

    private func setupCollectionView() {
          collectionView.dataSource = self
          collectionView.delegate = self

       
//          let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//          let itemSize = CGSize(width: (view.frame.width), height: 200)
//          layout.itemSize = itemSize
      }

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
    
    func heightForView(text:String, fontSize:CGFloat, width:CGFloat) -> CGFloat{
             let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
             label.numberOfLines = 0
             label.lineBreakMode = NSLineBreakMode.byWordWrapping
      
             label.font = UIFont(name: "Montserrat-Bold", size: fontSize)
             label.text = text

             label.sizeToFit()
             return label.frame.height
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
//        _ = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
       let text = questions[indexPath.row].question
        
        let size = heightForView(text: text, fontSize: 12, width: 271)
        let itemSize = CGSize(width: 271, height: size + 34)
         return itemSize
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
            make.top.equalTo(view.snp.top).offset(52)
            make.left.equalTo(view.snp.left).offset(30)
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
            make.top.equalTo(labelContainer.snp.bottom).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(170.04)
            make.height.equalTo(163.3)
            
        }
        
        nutsText.snp.makeConstraints { make in
            make.top.equalTo(nutsView.snp.bottom).offset(27.7)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(255)
            make.height.equalTo(25)
        }
        
        collectionView.snp.makeConstraints { make in
//            make.left.equalTo(labelContainer.snp.left)
//            make.right.equalTo(labelContainer.snp.right)
            make.centerX.equalTo(labelContainer.snp.centerX)
            make.width.equalTo(labelContainer.snp.width)
            make.top.equalTo(labelContainer.snp.bottom).offset(1)
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



