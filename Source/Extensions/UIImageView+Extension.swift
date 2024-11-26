//
//  UIImageView+Extension.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let data = try? Data(contentsOf: url) else {
				DispatchQueue.main.async { self?.image = .imageNotFound }
				return
			}
			guard let image = UIImage(data: data) else {
				DispatchQueue.main.async { self?.image = .imageNotFound }
				return
			}

			DispatchQueue.main.async { self?.image = image }
		}
	}
}
