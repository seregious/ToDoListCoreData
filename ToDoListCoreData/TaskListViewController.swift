//
//  ViewController.swift
//  ToDoListCoreData
//
//  Created by Сергей Иванчихин on 22.04.2022.
//

import UIKit
import CoreData

protocol TaskViewControllerDelegate {
    func reloadData()
}

class TaskListViewController: UITableViewController {
    
    private let context = DataManager.shared
    
    private let cellID = "task"
    private var taskList = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        setupNavigationBar()
        fetchData()
    }
    
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .purple
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func addNewTask() {
        showAlert(with: "New Taks", and: "What do you want to do")
    }
    
    private func fetchData() {
        context.fetchData { result in
            switch result {
            case .success(let tasks):
                self.taskList = tasks
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveData(_ taskName: String) {
        context.saveData(taskName) { task in
            self.taskList.append(task)
            self.tableView.insertRows(at: [IndexPath(row: self.taskList.count - 1, section: 0)], with: .automatic)
        }
    }
    
    private func editData(_ task: String, indexPath: IndexPath) {
        context.editData(taskList[indexPath.row], newName: task)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
    private func showAlert(with title: String, and massage: String, newTask: Bool = true, indexPath: IndexPath = [0,0]) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: newTask ? "Save" : "Edit", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            newTask ? self.saveData(task) : self.editData(task, indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = newTask ? "New Task" : "Edit Task"
        }
        
        present(alert, animated: true)
    }
    
    
}

//MARK: - TableView

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(with: "Update task", and: "You can edit your task", newTask: false, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if editingStyle == .delete {
            let task = taskList[index]
            context.deleteData(task)
            
            taskList.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - Delegate
extension TaskListViewController: TaskViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
