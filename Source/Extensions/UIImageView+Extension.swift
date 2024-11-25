//
//  UIImageView+Extension.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
