//
//  ViewController.swift
//  ToDoListCoreData
//
//  Created by Сергей Иванчихин on 22.04.2022.
//

import UIKit

class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
    }


    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .purple
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]

        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

