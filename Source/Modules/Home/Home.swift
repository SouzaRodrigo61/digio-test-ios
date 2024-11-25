//
//  Home.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import UIKit

enum Home {
    static func builder() -> UIViewController {
		let viewModel = ViewModel(repository: .init())
        let viewController = ViewController(viewModel: viewModel)

        return viewController
    }
}
