//
//  ExperienceViewController.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

class ExperienceViewController: UIViewController {
    
    var presenter: ExperiencePresentation?
    
    let tableViewExperience: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var jobs = [Job]()
    
    enum Constraints {
        
        enum TableViewExperience {
            static let top: CGFloat = 15
            static let bottom: CGFloat = 15
            static let rowHeight: CGFloat = 120
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
        title = "Experience"
        view.addSubview(tableViewExperience)
        tableViewExperience.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell.identifier)
        tableViewExperience.delegate = self
        tableViewExperience.dataSource = self
    }
    
    func setupConstraints() {
        tableViewExperience.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewExperience.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.TableViewExperience.top),
            tableViewExperience.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewExperience.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewExperience.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constraints.TableViewExperience.bottom)
            ])
    }
    
}

extension ExperienceViewController: ExperienceView {
    
    func loadExperience(_ jobs: [Job]) {
        DispatchQueue.main.async {
            [weak self] in
            self?.hideLoader(completion: {
                self?.loadTableViewExperience(with: jobs)
            })
        }
    }
    
    func loadTableViewExperience(with: [Job]) {
        self.jobs = with
        self.tableViewExperience.reloadData()
    }
    
    func showError(_ error: String) {
        self.hideLoader(completion: {
            [weak self] in
            self?.showAlertError(error)
        })
    }
    
}

//MARK: UITableview DataSource & Delegate
extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.identifier) as? JobTableViewCell else {
            return UITableViewCell()
        }
        let job = jobs[indexPath.row]
        cell.setJobData(job: job)
        cell.setDescriptionHeight(height: estimatedHeightForText(job.description))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let job = jobs[indexPath.row]
        return estimatedHeightForText(job.description) + JobTableViewCell.Constraints.Company.height + JobTableViewCell.Constraints.Date.height + JobTableViewCell.Constraints.Title.height
    }
    
    private func estimatedHeightForText(_ text: String) -> CGFloat {
        //Approximate size of the label view (substracting other views width)
        let approximateWidthOfTextView = view.frame.width - CGFloat(JobTableViewCell.Constraints.Company.leading * 6.0)
        let size = CGSize(width: approximateWidthOfTextView, height: 1000)
        let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: .medium)]
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height
    }
}
