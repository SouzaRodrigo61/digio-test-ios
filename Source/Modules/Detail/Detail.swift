//
//  Detail.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import UIKit

enum Detail {
    static func builder() -> UIViewController {
        let viewModel = ViewModel()
        let viewController = ViewController(model: viewModel)

        return viewController
    }
}
