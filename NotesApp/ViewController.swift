//
//  ViewController.swift
//  NotesApp
//
//  Created by Женя Мирзаметов on 12.12.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    var notes = [String]() // Массив заметок

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка интерфейса
        setupUI()

        // Загрузка данных
        loadNotes()
    }

    // MARK: - UI Setup
    private func setupUI() {
        // Устанавливаем заголовок
        navigationItem.title = "Заметки"

        // Добавляем кнопки в навигацию
        let settingsButton = UIBarButtonItem(title: "Настройки", style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsButton

        // Создаём "плавающую" кнопку для добавления заметок
        let floatingAddButton = UIButton(type: .system)
        floatingAddButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        floatingAddButton.tintColor = .systemBlue
        floatingAddButton.translatesAutoresizingMaskIntoConstraints = false
        floatingAddButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        view.addSubview(floatingAddButton)

        // Устанавливаем Auto Layout для кнопки
        NSLayoutConstraint.activate([
            floatingAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingAddButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            floatingAddButton.widthAnchor.constraint(equalToConstant: 60),
            floatingAddButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        // Настраиваем таблицу
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Actions
    @objc func openSettings() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            navigationController?.pushViewController(settingsVC, animated: true)
        } else {
            print("Ошибка: SettingsViewController не найден!")
        }
    }

    @objc func addNote() {
        let alert = UIAlertController(title: "Новая заметка", message: "Введите текст заметки", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Текст заметки"
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.notes.append(text)
                self.tableView.reloadData()
                self.saveNotes()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(addAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    // MARK: - Data Management
    private func saveNotes() {
        UserDefaults.standard.set(notes, forKey: "Notes")
        print("Заметки сохранены")
    }

    private func loadNotes() {
        if let savedNotes = UserDefaults.standard.array(forKey: "Notes") as? [String] {
            notes = savedNotes
            print("Заметки загружены!")
        }
    }

    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.noteText = notes[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            print("Ошибка: DetailViewController не найден!")
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveNotes()
        }
    }

    // MARK: - Gesture Handling
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: point) {
                let alert = UIAlertController(title: "Редактировать", message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.text = self.notes[indexPath.row]
                }
                let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    if let updatedText = alert.textFields?.first?.text, !updatedText.isEmpty {
                        self.notes[indexPath.row] = updatedText
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        self.saveNotes()
                    }
                }
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                
                alert.addAction(saveAction)
                alert.addAction(cancelAction)

                present(alert, animated: true, completion: nil)
            }
        }
    }
}
