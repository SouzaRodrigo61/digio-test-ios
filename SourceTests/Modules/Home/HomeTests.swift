//
//  HomeViewController.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import XCTest
@testable import Digio

extension Manager.Network {
	public static let homeTestSuccess = Self(
		get: { _, completion in
			completion(.success(Data(productsSuccess)))
		},
		post: { _, _, _ in },
		put: { _, _, _ in },
		delete: { _, _ in }
	)

	public static let homeTestDecodeFailure = Self(
		get: { _, completion in
			completion(.success(Data(productsDecodeError)))
		},
		post: { _, _, _ in },
		put: { _, _, _ in },
		delete: { _, _ in }
	)

	public static let homeTestFailure = Self(
		get: { _, completion in
			completion(.failure(.invalidResponse))
		},
		post: { _, _, _ in },
		put: { _, _, _ in },
		delete: { _, _ in }
	)
}

final class HomeRepositoryTest: XCTestCase {

	func testFetchProducts_Success() {
		let repository: Home.Repository = .init(network: .homeTestSuccess)

		repository.fetchProducts { result in
			// Assert
			switch result {
			case let .success(products):
				XCTAssertEqual(products.cash, expectedProducts.cash)
				XCTAssertEqual(products.products.filter { $0.name == "XBOX"},
							   expectedProducts.products.filter { $0.name == "XBOX"})
			case .failure:
				XCTFail("Expected success but got failure")
			}
		}
	}

	func testFetchProducts_FailureDecoding() {
		let repository: Home.Repository = .init(network: .homeTestDecodeFailure)

		repository.fetchProducts { result in
			// Assert
			switch result {
			case .success:
				XCTFail("Expected success but got failure")
			case let .failure(.decode(msg, _)):
				XCTAssertEqual(msg, "Failure for decoding data")
			case .failure(.network):
				XCTFail("Expected decoding failure")
			}
		}
	}

	func testFetchProducts_FailureNetworking() {
		let repository: Home.Repository = .init(network: .homeTestFailure)

		repository.fetchProducts { result in
			repository.fetchProducts { result in
				// Assert
				switch result {
				case .failure(let error):
					XCTAssertEqual(error, .network(.invalidResponse))
				case .success:
					XCTFail("Expected failure but got success")
				}
			}
		}
	}
}
