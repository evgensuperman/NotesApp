//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Женя Мирзаметов on 12.12.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var themeSwitch: UISwitch!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка интерфейса
        setupUI()
    }

    // MARK: - Actions
    @IBAction func themeSwitchToggled(_ sender: UISwitch) {
        let isDarkMode = sender.isOn
        print("Переключатель изменён: \(isDarkMode ? "Dark Mode" : "Light Mode")")
        
        // Сохраняем состояние переключателя
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        
        // Применяем тему
        applyTheme(isDarkMode: isDarkMode)
    }

    // MARK: - Private Methods
    private func setupUI() {
        // Устанавливаем начальное состояние переключателя
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        themeSwitch.isOn = isDarkMode
        print("Начальное состояние темы: \(isDarkMode ? "Dark" : "Light")")
        
        // Применяем текущую тему
        applyTheme(isDarkMode: isDarkMode)
    }
    
    private func applyTheme(isDarkMode: Bool) {
        print("Применяем тему: \(isDarkMode ? "Dark Mode" : "Light Mode")")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
