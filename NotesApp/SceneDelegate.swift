//
//  SceneDelegate.swift
//  NotesApp
//
//  Created by Женя Мирзаметов on 12.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    var window: UIWindow?

    // MARK: - UIWindowScene Lifecycle
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Создание основного окна
        window = UIWindow(windowScene: windowScene)
        
        // Установка сохранённой темы
        applySavedTheme()
        
        // Установка начального ViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Вызывается при отключении сцены
        // Освобождаем ресурсы, если они больше не нужны
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена становится активной
        // Перезапускаем приостановленные задачи
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена становится неактивной
        // Используется для временных прерываний (например, входящий звонок)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из фона в активное состояние
        // Восстанавливаем состояние интерфейса
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается, когда сцена переходит в фоновый режим
        // Сохраняем данные и освобождаем ресурсы
    }

    // MARK: - Private Methods
    private func applySavedTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        print("Применена тема: \(isDarkMode ? "Dark Mode" : "Light Mode")")
    }
}
