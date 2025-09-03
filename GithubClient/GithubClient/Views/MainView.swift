//
//  MainView.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class MainView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension MainView {
    
    private func setupView(){

    }
    
    private func style() {
        backgroundColor = .blue
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false

    }

}

