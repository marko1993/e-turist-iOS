//
//  NavigationViewController.swift
//  eTurist
//
//  Created by Marko on 19.08.2021..
//

import UIKit

class NavigationViewController: LocationViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.tintColor = UIColor(named: K.Color.main)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "leftArrow")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white), style: .done, target: self, action: #selector(self.backPressed(sender:)))
        self.navigationController?.navigationBar.setGradientBackground(colors: [UIColor(named: K.Color.main)!, UIColor(named: K.Color.main)!], startPoint: .topCenter, endPoint: .bottomCenter, locations: [0, 1])
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.removeGradientBackground()
    }
    
    @objc open func backPressed(sender: AnyObject) {
        
   }
    
    func setupNavigation(title: String, logo: UIImage? = nil, shouldEnableSaveButton: Bool = true) {
        let titleView: UIStackView = {
            let stackView: UIStackView = {
                let view = UIStackView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.axis = .horizontal
                view.distribution = .fill
                view.alignment = .fill
                view.spacing = 4.0
                return view
            } ()
            
            let titleLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = UIFont.boldSystemFont(ofSize: 22)
                label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
                label.setContentHuggingPriority(.defaultHigh, for: .vertical)
                label.textColor = .white
                label.text = title
                return label
            } ()
            
            stackView.addArrangedSubview(titleLabel)
            
            stackView.constrainHeight(30.0)
            
            return stackView
            
        } ()
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.navigationItem.titleView = titleView
        
    }
}
