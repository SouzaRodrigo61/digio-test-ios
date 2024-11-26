//
//  DetailSpotlightController.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 25/11/2024.
//

import UIKit

extension Detail {
	class ViewModel: Identifiable {
		var sections: Section

		init(_ title: String, _ bannerURL: String, _ description: String) {
			self.sections = .init(row: [
				.bannerURL(bannerURL),
				.name(title),
				.description(description)
			])
		}
	}
}

extension Detail.ViewModel {
	struct Section {
		var row: [Row]
	}

	enum Row {
		case bannerURL(String)
		case name(String)
		case description(String)
	}
}
