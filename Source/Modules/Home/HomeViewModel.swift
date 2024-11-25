//
//  HomeController.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import Foundation
import UIKit

extension Home {
    class ViewModel {

		// MARK: - Repository

		private var repository: Repository

		// MARK: - UI Controlling

		var products: Products?
		var sections: [Section] = []

		// MARK: - Internal section

		private let produtcsTitleSection: NSAttributedString = {
			let attr = NSAttributedString(string: "Produtos", attributes: [
				.font: UIFont.systemFont(ofSize: 24, weight: .bold),
				.foregroundColor: UIColor.blue
			])

			return attr
		}()

		private let cashTitleSection: NSMutableAttributedString = {
			let attr = NSMutableAttributedString()
			let title = NSAttributedString(string: "Digio ", attributes: [
				.font: UIFont.systemFont(ofSize: 24, weight: .bold),
				.foregroundColor: UIColor.blue
			])
			let subTitle = NSAttributedString(string: "Cash", attributes: [
				.font: UIFont.systemFont(ofSize: 24, weight: .bold),
				.foregroundColor: UIColor.gray
			])
			attr.append(title)
			attr.append(subTitle)

			return attr
		}()

		init(repository: Repository) {
			self.repository = repository
		}

		// MARK: - Lifecycle

		func fetchProducts(completion: @escaping (Result<(), Repository.ProductsError>) -> Void) {
			repository.fetchProducts { [weak self] result in
				guard let self else { return }
				switch result {
				case .success(let data):
					products = data
					sections = [
						.init(isHorizontal: true,
							  row: [.spotlight(data.spotlight)]),
						.init(title: cashTitleSection,
							  row: [.cash(data.cash)]),
						.init(isHorizontal: true,
							  title: produtcsTitleSection,
							  row: [.products(data.products)])
					]
					completion(.success(()))
				case .failure(let error):
					completion(.failure(error))
				}
			}
		}
	}
}

extension Home.ViewModel {
	struct Products: Codable, Equatable {
		let spotlight: [Spotlight]
		let products: [Product]
		let cash: Cash
	}

	struct Cash: Codable, Equatable {
		let title: String
		let bannerURL: String
		let description: String
	}

	struct Product: Codable, Equatable {
		let name: String
		let imageURL: String
		let description: String
	}

	struct Spotlight: Codable, Equatable {
		let name: String
		let bannerURL: String
		let description: String
	}
}

// MARK: - Control UI

extension Home.ViewModel {
	struct Section {
		var isHorizontal: Bool = false
		var title: NSAttributedString?
		var row: [Row]
	}

	enum Row {
		case spotlight([Home.ViewModel.Spotlight])
		case products([Home.ViewModel.Product])
		case cash(Home.ViewModel.Cash)
	}
}
