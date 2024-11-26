//
//  DetailSpotlight.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 25/11/2024.
//

import UIKit

enum Detail {
	static func builder(
		_ title: String,
		_ bannerURL: String,
		_ description: String
	) -> UIViewController {
        let viewModel = ViewModel(title, bannerURL, description)
        let viewController = ViewController(viewModel: viewModel)

        return viewController
    }
}
