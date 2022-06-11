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
              let navigationBarAppearance = UINavigationBarAppearance()
              navigationBarAppearance.configureWithDefaultBackground()
              UINavigationBar.appearance().standardAppearance = navigationBarAppearance
              UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

              let tabBarAppearance = UITabBarAppearance()
              tabBarAppearance.configureWithDefaultBackground()
              UITabBar.appearance().standardAppearance = tabBarAppearance
              UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }

        let tabBarController = UITabBarController()

        let firstViewControler = UIViewController()
        firstViewControler.tabBarItem = UITabBarItem(title: "Медиатека", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        let secondViewControler = UIViewController()
        secondViewControler.tabBarItem = UITabBarItem(title: "Для Вас", image: UIImage(systemName: "heart.text.square.fill"), tag: 1)
        let thirdViewControler = UINavigationController()
        thirdViewControler.tabBarItem = UITabBarItem(title: "Альбомы", image: UIImage(systemName: "rectangle.stack.fill"), tag: 2)
        let fourthViewControler = UIViewController()
        fourthViewControler.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        tabBarController.setViewControllers([
            firstViewControler,
            secondViewControler,
            thirdViewControler,
            fourthViewControler
        ], animated: true)


        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

