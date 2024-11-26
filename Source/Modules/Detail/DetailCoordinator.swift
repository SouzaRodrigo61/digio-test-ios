//
//  DetailSpotlight.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 25/11/2024.
//

import UIKit

extension Coordinating where A == UINavigationController {

	static func coordinatorDetail(
		title: String,
		bannerURL: String,
		description: String
	) -> Self {
        Self { navigationController in
			let viewController = Detail.builder(title, bannerURL, description)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
