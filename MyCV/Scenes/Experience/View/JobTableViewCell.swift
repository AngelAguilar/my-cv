//
//  JobTableViewCell.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/10/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    static let identifier = "JobTableViewCell"
    
    enum Constraints {
        enum Company {
            static let top: CGFloat = 10
            static let leading: CGFloat = 10
            static let height: CGFloat = 50
        }
        enum Date {
            static let top: CGFloat = 10
            static let trailing: CGFloat = -10
            static let height: CGFloat = 50
        }
        
        enum Title {
            static let top: CGFloat = 10
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -10
            static let height: CGFloat = 30
        }
        
        enum Description {
            static let top: CGFloat = 10
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -10
        }
    }
    
    private let labelCompany: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(labelCompany)
        addSubview(labelDate)
        addSubview(labelTitle)
        addSubview(labelDescription)
    }
    
    private func setupConstraints() {
        labelCompany.translatesAutoresizingMaskIntoConstraints = false
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelCompany.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCompany.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.Company.top),
            labelCompany.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.Company.leading),
            labelCompany.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7, constant: 1.0),
            labelCompany.heightAnchor.constraint(equalToConstant: Constraints.Company.height),
            labelDate.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.Date.top),
            labelDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constraints.Date.trailing),
            labelDate.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2, constant: 1.0),
            labelDate.heightAnchor.constraint(equalToConstant: Constraints.Date.height),
            labelTitle.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: Constraints.Title.top),
            labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constraints.Title.trailing),
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.Title.leading),
            labelTitle.heightAnchor.constraint(equalToConstant: Constraints.Title.height),
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: Constraints.Description.top),
            labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constraints.Description.trailing),
            labelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.Description.leading)
        ])
    }
    
    func setJobData(job: Job) {
        labelCompany.text = job.company
        labelDate.text = job.date
        labelTitle.text = job.title
        labelDescription.text = job.description
    }
    
    func setDescriptionHeight(height: CGFloat) {
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.heightAnchor.constraint(equalToConstant: height)
    }
}

