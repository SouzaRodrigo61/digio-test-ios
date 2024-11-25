//
//  Manager+Network.swift
//  Digio
//
//  Created by Rodrigo Souza on 23/11/24.
//

import Foundation

extension Manager {
	struct Network: Sendable {
		private let configuration: Configuration = .default

		public var get: @Sendable (String, @escaping (Result<Data, NetworkError>) -> Void) -> Void
		public var post: @Sendable (String, Data?, @escaping (Result<Data, NetworkError>) -> Void) -> Void
		public var put: @Sendable (String, Data?, @escaping (Result<Data, NetworkError>) -> Void) -> Void
		public var delete: @Sendable (String, @escaping (Result<Data, NetworkError>) -> Void) -> Void
	}
}

extension Manager.Network {
	struct Configuration {
		let baseURL: URL
		let timeout: TimeInterval
		let retryCount: Int

		static let `default` = Configuration(
			baseURL: URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com")!,
			timeout: 10,
			retryCount: 3
		)
	}

	enum NetworkError: Error, Equatable {
		case connectionError(String)
		case invalidResponse
		case decodingError(String)
		case serviceException(ServiceException)
	}

	enum Method: String {
		case get = "GET"
		case post = "POST"
		case put = "PUT"
		case delete = "DELETE"
	}

	struct ServiceException: Codable, Equatable {
		let message: String
		let code: Int
	}

	struct ResponseContext {
		let attempt: Int
		let configuration: Configuration
		let retry: (Int) -> Void
		let completion: (Result<Data, NetworkError>) -> Void
	}
}

extension Manager.Network {
	public static let liveValue: Self = {
		let configuration = Configuration.default
		return Self(
			get: { endpoint, completion in
				request(endpoint: endpoint,
						method: .get,
						configuration: configuration,
						completion: completion)
			},
			post: { endpoint, body, completion in
				request(endpoint: endpoint,
						method: .post,
						body: body,
						configuration: configuration,
						completion: completion)
			},
			put: { endpoint, body, completion in
				request(endpoint: endpoint,
						method: .put,
						body: body,
						configuration: configuration,
						completion: completion)
			},
			delete: { endpoint, completion in
				request(endpoint: endpoint,
						method: .delete,
						configuration: configuration,
						completion: completion)
			}
		)
	}()

	private static func request(
		endpoint: String,
		method: Method,
		body: Data? = nil,
		configuration: Configuration,
		completion: @escaping (Result<Data, NetworkError>) -> Void
	) {
		let url = configuration.baseURL.appendingPathComponent(endpoint)
		let session = configureSession(with: configuration)

		func performRequest(attempt: Int) {
			var request = URLRequest(url: url)
			request.httpMethod = method.rawValue
			request.httpBody = body

			interceptRequest(&request)

			let task = session.dataTask(with: request) { data, response, error in
				let context = ResponseContext(
					attempt: attempt,
					configuration: configuration,
					retry: performRequest,
					completion: completion
				)

				do {
					try handleResponse(data: data, response: response, error: error, context: context)
				} catch {
					context.completion(.failure(.decodingError(error.localizedDescription)))
				}
			}
			task.resume()
		}

		performRequest(attempt: 0)
	}

	private static func configureSession(with configuration: Configuration) -> URLSession {
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = configuration.timeout
		return URLSession(configuration: sessionConfig)
	}

	private static func handleResponse(
		data: Data?,
		response: URLResponse?,
		error: Error?,
		context: ResponseContext
	) throws {
		if let error = error {
			handleConnectionError(error, context: context)
			return
		}

		guard let httpResponse = response as? HTTPURLResponse else {
			context.completion(.failure(.invalidResponse))
			return
		}

		guard let data = data else {
			context.completion(.failure(.invalidResponse))
			return
		}

		switch httpResponse.statusCode {
		case 200...299:
			context.completion(.success(data))
		case 400...599:
			handleServerError(data: data, statusCode: httpResponse.statusCode, context: context)
		default:
			context.completion(.failure(.invalidResponse))
		}
	}

	private static func handleConnectionError(_ error: Error, context: ResponseContext) {
		if context.attempt < context.configuration.retryCount {
			scheduleRetry(context)
		} else {
			context.completion(.failure(.connectionError(error.localizedDescription)))
		}
	}

	private static func handleServerError(data: Data, statusCode: Int, context: ResponseContext) {
		do {
			let serviceError = try decodeServiceError(data)
			if shouldRetry(statusCode: statusCode,
						   attempt: context.attempt,
						   maxAttempts: context.configuration.retryCount) {
				scheduleRetry(context)
			} else {
				context.completion(.failure(.serviceException(serviceError)))
			}
		} catch {
			context.completion(.failure(.decodingError(error.localizedDescription)))
		}
	}

	private static func decodeServiceError(_ data: Data) throws -> ServiceException {
		return try JSONDecoder().decode(ServiceException.self, from: data)
	}

	private static func shouldRetry(statusCode: Int, attempt: Int, maxAttempts: Int) -> Bool {
		return statusCode >= 500 && attempt < maxAttempts
	}

	private static func scheduleRetry(_ context: ResponseContext) {
		let delay = pow(2.0, Double(context.attempt)) // Backoff exponencial
		DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
			context.retry(context.attempt + 1)
		}
	}

	private static func interceptRequest(_ request: inout URLRequest) {
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.setValue("json", forHTTPHeaderField: "X-Requested-With")
		request.setValue("application/json", forHTTPHeaderField: "Accept-Encoding")
	}
}
