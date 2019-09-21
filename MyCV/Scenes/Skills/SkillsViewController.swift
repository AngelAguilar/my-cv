//
//  SkillsViewController.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController {

    var presenter: SkillsPresentation?
    
    let tableViewSkills: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = Constraints.TableViewSkills.rowHeight
        tableView.tableFooterView = UIView()
        return tableView
    }()
    let cellSkillsIdentifier = "cellSkillsIdentifier"
    var skills = [Skill]()
    
    enum Constraints {
        
        enum TableViewSkills {
            static let top: CGFloat = 15
            static let bottom: CGFloat = 15
            static let rowHeight: CGFloat = 60
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        showLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
        
    }
    
    func setupViews() {
        title = "Skills"
        view.addSubview(tableViewSkills)
        tableViewSkills.register(UITableViewCell.self, forCellReuseIdentifier: cellSkillsIdentifier)
        tableViewSkills.delegate = self
        tableViewSkills.dataSource = self
    }
    
    func setupConstraints() {
        tableViewSkills.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewSkills.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.TableViewSkills.top),
            tableViewSkills.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewSkills.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewSkills.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constraints.TableViewSkills.bottom)
            ])
    }
    
}

extension SkillsViewController: SkillsView {
    
    func loadSkills(_ skills: [Skill]) {
        DispatchQueue.main.async {
            [weak self] in
            self?.hideLoader(completion: {
                self?.loadTableViewSkills(with: skills)
            })
        }
    }
    
    func loadTableViewSkills(with: [Skill]) {
        self.skills = with
        self.tableViewSkills.reloadData()
    }
    
    func showError(_ error: String) {
        self.hideLoader(completion: {
            [weak self] in
                self?.showAlertError(error)
        })
    }
    
}

//MARK: UITableview DataSource & Delegate
extension SkillsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: cellSkillsIdentifier) else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellSkillsIdentifier)
        let skill = skills[indexPath.row]
        cell.selectionStyle = .none
        
        cell.textLabel?.text = skill.name
        cell.detailTextLabel?.text = skill.description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constraints.TableViewSkills.rowHeight
    }
}
