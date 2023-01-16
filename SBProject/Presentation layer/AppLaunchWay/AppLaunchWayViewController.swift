//
//  AppLaunchWayViewController.swift
//  Pixpot
//
//  Created by Vladimir on 16.01.2023.
//

import UIKit

class AppLaunchWayViewController: UIViewController {

    let viewModel: AppLaunchWayViewModelProtocol

    // MARK: - Init
    init(viewModel: AppLaunchWayViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(hexString: "#63B7F8")
        // TODO: MAKE Launcher
    }
}
