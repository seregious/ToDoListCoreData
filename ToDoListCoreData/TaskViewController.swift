//
//  TaskViewController.swift
//  ToDoListCoreData
//
//  Created by Сергей Иванчихин on 22.04.2022.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    
    var data: DataManager!
    
    // задаются тектовое поле и 2 кнопки
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        setButton(text: "Save Task", textColor: .white, backgroundColor: .purple, action: #selector(save))
    }()
    
    private lazy var cancelButton: UIButton = {
        setButton(text: "Cancel", textColor: .white, backgroundColor: .gray, action: #selector(cancel))
    }()
    
    //инициализация экрана
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(textField, saveButton, cancelButton) //инициализация контента на экране
        setConst()
    }
    
    private func setupSubviews(_ subviews: UIView...) { //метод инициализации контента
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    // установка расположения элементов относительно границ экрана и друг друга, для каждого элемента необходимо минимум 3 параметра
    private func setConst() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 80),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc private func save() {
        
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
}

extension TaskViewController {
    private func setButton(text: String, textColor: UIColor, backgroundColor: UIColor,action: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = backgroundColor
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(textColor, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
}

