//
//  AppDelegate.swift
//  IOS6-HW14-AlekseiKudinov
//
//  Created by Алексей Кудинов on 11.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions  launchOptions:  [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 15, *) {

            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithTransparentBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        let tabBarController = UITabBarController()

        let firstViewControler = UIViewController()
        firstViewControler.view.backgroundColor = .white
        firstViewControler.tabBarItem = UITabBarItem(title: "Медиатека", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        let secondViewControler = UIViewController()
        secondViewControler.view.backgroundColor = .white
        secondViewControler.tabBarItem = UITabBarItem(title: "Для Вас", image: UIImage(systemName: "heart.text.square.fill"), tag: 1)
        let thirdViewControler = AlbumsViewController()
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewControler)
        thirdViewControler.tabBarItem = UITabBarItem(title: "Альбомы", image: UIImage(systemName: "rectangle.stack.fill"), tag: 2)
        let fourthViewControler = UIViewController()
        fourthViewControler.view.backgroundColor = .white
        fourthViewControler.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        tabBarController.setViewControllers([
            firstViewControler,
            secondViewControler,
            thirdNavigationController,
            fourthViewControler
        ], animated: true)

        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        tabBarController.selectedIndex = 2

        return true
    }
}

