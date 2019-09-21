//
//  ViewController.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/7/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    let sections = ["Skills","Experience"]
    let cellSectionIdentifier = "cellSectionIdentifier"
    
    enum Constraints {
        
        enum StackView {
            static let top: CGFloat = 20
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -10
            static let height: CGFloat = 300
            static let spacing: CGFloat = 10
        }
        
        enum ImageViewAvatar {
            static let height: CGFloat = 100
            static let width: CGFloat = 100
        }
        enum LabelName {
            static let height: CGFloat = 50
        }
        enum LabelTitle {
            static let height: CGFloat = 50
        }
        enum LabelEmail {
            static let height: CGFloat = 50
        }
        enum LabelSummary {
            static let height: CGFloat = 50
        }
        enum TableViewSections {
            static let height: CGFloat = 100
            static let rowHeight: CGFloat = 50
        }
    }
    
    var presenter: MyProfilePresentation?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let stackViewProfile: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = Constraints.StackView.spacing
        return stackView
    }()
    
    let tableViewSections: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorColor = .lightGray
        tableView.estimatedRowHeight = Constraints.TableViewSections.rowHeight
        return tableView
    }()
    
    let imageViewAvatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let labelEmail: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let labelSummary: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupConstraints()
        showLoader()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Profile"
    }

    func setupViews() {
        stackViewProfile.addArrangedSubview(imageViewAvatar)
        stackViewProfile.addArrangedSubview(labelName)
        stackViewProfile.addArrangedSubview(labelTitle)
        stackViewProfile.addArrangedSubview(labelEmail)
        stackViewProfile.addArrangedSubview(labelSummary)
        stackViewProfile.addArrangedSubview(tableViewSections)
        scrollView.addSubview(stackViewProfile)
        view.addSubview(scrollView)
        tableViewSections.register(UITableViewCell.self, forCellReuseIdentifier: cellSectionIdentifier)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageViewAvatar.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelSummary.translatesAutoresizingMaskIntoConstraints = false
        stackViewProfile.translatesAutoresizingMaskIntoConstraints = false
        tableViewSections.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewAvatar.heightAnchor.constraint(equalToConstant: Constraints.ImageViewAvatar.height),
            imageViewAvatar.widthAnchor.constraint(equalToConstant: Constraints.ImageViewAvatar.width),
            tableViewSections.heightAnchor.constraint(equalToConstant: Constraints.TableViewSections.height),
            tableViewSections.widthAnchor.constraint(equalTo: stackViewProfile.widthAnchor, multiplier: 1.0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackViewProfile.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackViewProfile.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constraints.StackView.leading),
            stackViewProfile.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Constraints.StackView.trailing),
            stackViewProfile.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constraints.StackView.top),
            stackViewProfile.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
    }
    
}

extension MyProfileViewController: MyProfileView {
    func showError(_ error: String) {
        self.hideLoader(completion: {
            [weak self] in
            self?.showAlertError(error)
        })
    }
    
    
    func loadProfileImageData(_ data: Data) {
        DispatchQueue.main.async {
            [weak self] in
            self?.imageViewAvatar.transition(toImage: UIImage(data: data))
        }
    }
    
    func loadProfileData(_ data: Profile) {
        DispatchQueue.main.async {
            [weak self] in
                self?.loadProfile(profile: data)
        }
    }
    func loadProfile(profile: Profile) {
        hideLoader(completion: nil)
        labelName.text = profile.name
        labelEmail.text = profile.email
        labelTitle.text = profile.title
        
        labelSummary.text = profile.summary
        if !profile.profile_image_url.isEmpty {
            presenter?.getProfileImageData(from: profile.profile_image_url)
        }
        tableViewSections.delegate = self
        tableViewSections.dataSource = self
    }
}

//MARK: UITableview DataSource & Delegate
extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = sections[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constraints.TableViewSections.rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter?.didTapSkills()
        default:
            presenter?.didTapExperience()
        }
    }
}
