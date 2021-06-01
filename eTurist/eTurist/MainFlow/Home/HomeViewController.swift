//
//  HomeViewController.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit
import RxSwift

class HomeViewController: UIPageViewController {
    
    let bottomTabContainer = UIView()
    let bottomBarTab = UIStackView()
    
    let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!
    var tabBarItems: [TabBarItem] = []
    var currentViewControllerIndex: Int = 0
    
    lazy var tabs: [StackItemView] = {
        var items = [StackItemView]()
        for _ in 0..<3 {
            items.append(StackItemView.newInstance)
        }
        return items
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        configureBotomNavigation()
    }
    
    func setupTabs() {
        for i in 0..<self.tabBarItems.count {
            let tabView = self.tabs[i]
            self.tabBarItems[i].isSelected = i == 0
            tabView.item = self.tabBarItems[i]
            tabView.delegate = self
            self.bottomBarTab.addArrangedSubview(tabView)
        }
    }
    
    
    
    private func getViewControllersIndex(_ viewController: BaseViewController?) -> Int? {
        if viewController == nil { return nil }
        for i in 0..<tabBarItems.count {
            if tabBarItems[i].viewController == viewController {
                return tabBarItems[i].position
            }
        }
        return nil
    }
    
    private func goToController(index: Int) {
        if index == currentViewControllerIndex { return }
        if index < 0 || index >= tabBarItems.count { return }
        if index < currentViewControllerIndex {
            setViewControllers([tabBarItems[index].viewController], direction: .reverse, animated: true, completion: nil)
        } else {
            setViewControllers([tabBarItems[index].viewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = getViewControllersIndex(viewController as? BaseViewController) else { return nil}
        self.currentViewControllerIndex = index
        if index == 0 { return nil }
        index -= 1
        return tabBarItems[index].viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = getViewControllersIndex(viewController as? BaseViewController) else { return nil}
        self.currentViewControllerIndex = index
        if index == tabBarItems.count - 1 { return nil }
        index += 1
        return tabBarItems[index].viewController
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let index = getViewControllersIndex(self.viewControllers?.first as? BaseViewController) else { return }
            self.tabs.forEach{$0.isSelected = false}
            self.tabs[index].isSelected = true
        }
    }
    
}

extension HomeViewController: StackItemViewDelegate {
    
    func handleTap(_ view: StackItemView) {
        self.tabs[self.currentViewControllerIndex].isSelected = false
        view.isSelected = true
        goToController(index: (view.item as! TabBarItem).position)
        self.currentViewControllerIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
    }
    
}
