//
//  Detail.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import UIKit

extension Coordinating where A == UINavigationController {

    static func coordinatorDetail() -> Self {
        return Self { navigationController in
            let viewController = Detail.builder()
            navigationController.pushViewController(viewController, animated: true)
        }
    }

}
