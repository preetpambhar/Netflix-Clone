//
//  OptionsViewController.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-09-04.
//
import UIKit

class OptionsViewController: UIViewController {
    private let options = ["Contact Us", "About Us", "Vision"]
    
    private let optionsTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "optionCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(optionsTable)
        optionsTable.delegate = self
        optionsTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        optionsTable.frame = view.bounds
    }
}

extension OptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedOption = options[indexPath.row]
        
        switch selectedOption {
        case "Contact Us":
            let vc = ContactUsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case "About Us":
            let vc = AboutUsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case "Vision":
            let vc = VisionViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
