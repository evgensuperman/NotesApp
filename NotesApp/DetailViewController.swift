//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Женя Мирзаметов on 12.12.2024.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var detailLabel: UILabel!

    // MARK: - Properties
    var noteText: String? // Текст заметки, переданный с предыдущего экрана

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем текст в метку
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        detailLabel.text = noteText
    }
}
