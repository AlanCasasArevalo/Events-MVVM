//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Everis on 29/07/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI () {
        self.view.backgroundColor = UIColor(named: ColorsConstants.mainColor)
        setupNavigation()
    }

    func getRightNavigationBar () -> UIBarButtonItem {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let right = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(rightButtonPressed))
        right.tintColor = UIColor(named: ColorsConstants.blueGreen)
        return right
    }

    func setupNavigation () {
        navigationItem.rightBarButtonItem = getRightNavigationBar()
        navigationItem.title = EventListConstants.eventListTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension EventListViewController {
    @objc func rightButtonPressed () {

    }
}
