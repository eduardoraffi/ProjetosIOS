//
//  DetailsView.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 15/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIView{
    
    var backView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var internView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var bannerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var gradeTextfield: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var favoriteImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var genreTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var countryTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var detailsTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsView: ViewCodable {
    func buildView() {
        addSubview(backView)
        backView.addSubview(internView)
        internView.addSubview(bannerImageView)
        internView.addSubview(gradeTextfield)
        internView.addSubview(favoriteImageView)
        internView.addSubview(titleTextField)
        internView.addSubview(genreTextField)
        internView.addSubview(countryTextField)
        internView.addSubview(detailsTextView)
    }
    
    func setupConstraints() {
        backView.layer.cornerRadius = 10
        backView.heightAnchor.constraint(equalToConstant: 235).isActive = true
        //Intern
        internView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        internView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        internView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8).isActive = true
        internView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8).isActive = true
        //Banner
        bannerImageView.leadingAnchor.constraint(equalTo: internView.leadingAnchor).isActive = true
        bannerImageView.topAnchor.constraint(equalTo: internView.topAnchor).isActive = true
        bannerImageView.bottomAnchor.constraint(equalTo: internView.bottomAnchor, constant: -8).isActive = true
        bannerImageView.widthAnchor.constraint(equalTo: internView.widthAnchor, multiplier: 0.213).isActive = true
        //Grade
        gradeTextfield.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 8).isActive = true
        gradeTextfield.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8).isActive = true
        //title
        titleTextField.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 8).isActive = true
        titleTextField.topAnchor.constraint(equalTo: internView.topAnchor).isActive = true
        //favoriteimg
        favoriteImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        favoriteImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        favoriteImageView.trailingAnchor.constraint(equalTo: internView.trailingAnchor).isActive = true
        favoriteImageView.firstBaselineAnchor.constraint(equalTo: titleTextField.firstBaselineAnchor).isActive = true
        //genre
        genreTextField.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor).isActive = true
        genreTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8).isActive = true
        genreTextField.trailingAnchor.constraint(equalTo: internView.trailingAnchor).isActive = true
        //country
        countryTextField.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor).isActive = true
        countryTextField.topAnchor.constraint(equalTo: genreTextField.bottomAnchor).isActive = true
        countryTextField.trailingAnchor.constraint(equalTo: internView.trailingAnchor).isActive = true
        //textview
        detailsTextView.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor).isActive = true
        detailsTextView.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 8).isActive = true
        detailsTextView.trailingAnchor.constraint(equalTo: internView.trailingAnchor).isActive = true
        detailsTextView.bottomAnchor.constraint(equalTo: internView.bottomAnchor).isActive = true
    }
    
    func setupAdditionalConfig() {
        backView.backgroundColor = .darkGray
        internView.backgroundColor = .clear
        gradeTextfield.backgroundColor = .systemIndigo
        gradeTextfield.textColor = .white
        gradeTextfield.font = UIFont.boldSystemFont(ofSize: 14)
        
        titleTextField.backgroundColor = .clear
        titleTextField.font = UIFont.boldSystemFont(ofSize: 16)
        
        genreTextField.backgroundColor = .clear
        countryTextField.backgroundColor = .clear
        detailsTextView.backgroundColor = .clear
        detailsTextView.textColor = .lightGray
        detailsTextView.isScrollEnabled = false
    }
}
