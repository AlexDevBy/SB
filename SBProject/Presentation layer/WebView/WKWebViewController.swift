//
//  BaseCoordinator.swift
//  SB
//
//  Created by Alex Misko on 11.01.23.
//


import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView: WKWebView = WKWebView()
    private let site: String
    private let navigationTitle: String?
    private let loadindicator = UIActivityIndicatorView()
    
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkBlue
        return view
    }()
    private let exitButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        return button
    }()
    
    private let loaderBackgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .none
        view.layer.cornerRadius = 10
//        view.dropShadow()
        return view
    }()
    

    
    init(site: String, title: String?, withExitButton: Bool, withBackButton:Bool) {
        self.site = site
        self.navigationTitle = title
        self.exitButton.isHidden = !withExitButton
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationTitle
        setupView()
        startLoading()
    }
    
    @objc func exitTapped() {
        dismiss(animated: true)
    }

    
    private func setupView() {
        view.backgroundColor = AppColors.white
        navigationController?.navigationBar.barTintColor = AppColors.darkBlue
        webView.navigationDelegate = self
        view.addSubview(webView)
        view.addSubview(bottomView)
        view.addSubview(loadindicator)
        webView.addSubview(loaderBackgroundView)
        webView.addSubview(exitButton)
        webViewConstraints()
        loaderBackgroundViewConstraints()
        loadindicatorConstraints()
        addGoBackButton()
    }
    
    @objc
    private func addGoBackButton() {
        if webView.canGoBack{
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: "ArrowLeft")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setTitle("Back", for: .normal)
            button.sizeToFit()
            button.tintColor = AppColors.darkBlue
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc
    private func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    private func loadindicatorConstraints() {
        loadindicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
    }

    private func webViewConstraints() {
     
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            
            make.width.height.equalTo(30)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }

        bottomView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    private func loaderBackgroundViewConstraints() {
        loaderBackgroundView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func startLoading() {
        guard let url = URL(string: site) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func showLoader(toggle: Bool) {
        if toggle {
            loadindicator.startAnimating()
            loaderBackgroundView.isHidden = false
        } else {
            loadindicator.stopAnimating()
            loaderBackgroundView.isHidden = true
        }
    }
}

//MARK: - WKWebView
extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader(toggle: true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showLoader(toggle: false)
        addGoBackButton()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showLoader(toggle: false)
        addGoBackButton()
    }
}
