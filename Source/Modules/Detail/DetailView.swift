//
//  DetailView.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import UIKit

extension Detail {
    final class ViewController: UIViewController {

        private var model: ViewModel

        init(model: ViewModel) {
            self.model = model
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .cyan
        }
    }
}
