//
//  HomeRepository.swift
//  Digio
//
//  Created by Rodrigo Souza on 23/11/24.
//

import Foundation

extension Home {
	struct Repository {
		let network: Manager.Network

		init(network: Manager.Network = .liveValue) {
			self.network = network
		}

		func fetchProducts(completion: @escaping (Result<ViewModel.Products, ProductsError>) -> Void) {
			network.get("/sandbox/products") { result in
				switch result {
				case .success(let data):
					do {
						let products = try JSONDecoder().decode(ViewModel.Products.self, from: data)
						completion(.success(products))
					} catch let error {
						completion(.failure(.decode(msg: "Failure for decoding data", error: error.localizedDescription)))
					}
				case .failure(let error):
					completion(.failure(.network(error)))
				}
			}
		}
	}
}

extension Home.Repository {
	enum ProductsError: Error {
		case network(Manager.Network.NetworkError)
		case decode(msg: String, error: String)
	}
}

extension Home.Repository.ProductsError: Equatable {
	static func == (lhs: Home.Repository.ProductsError, rhs: Home.Repository.ProductsError) -> Bool {
		switch (lhs, rhs) {
		case (.network(let lhsError), .network(let rhsError)):
			return lhsError == rhsError  // Comparando NetworkError
		case (.decode(let lhsMsg, let lhsError), .decode(let rhsMsg, let rhsError)):
			return lhsMsg == rhsMsg && lhsError == rhsError
		default:
			return false
		}
	}
}
