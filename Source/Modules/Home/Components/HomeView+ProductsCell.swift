//
//  HomeView+ProductCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit

extension Home.ViewController {

	// MARK: - ProductCell
	final class ProductsCell: UICollectionViewCell {
		static let identifier = "ProductsCell"

		var products: [Home.ViewModel.Product] = []
		var onHandler: ((Home.ViewModel.Product) -> Void)?

		// MARK: - UI Properties

		private lazy var collectionView: UICollectionView = {
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .horizontal
			let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
			collectionView.isPagingEnabled = true
			collectionView.showsHorizontalScrollIndicator = false
			collectionView.showsVerticalScrollIndicator = false
			return collectionView
		}()

		// MARK: - Initialize

		override init(frame: CGRect) {
			super.init(frame: frame)
			setupUI()
			setupCollectionView()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		// MARK: - Setup UI

		private func setupUI() {
			contentView.addSubview(collectionView)

			collectionView.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview()
				make.leading.trailing.equalToSuperview()
			}
		}

		private func setupCollectionView() {
			collectionView.delegate = self
			collectionView.dataSource = self

			collectionView.register(ProductCell.self,
									forCellWithReuseIdentifier: ProductCell.identifier)
		}

		// MARK: - Configurate

		func configure(
			with products: [Home.ViewModel.Product],
			onHandler: @escaping (Home.ViewModel.Product) -> Void
		) {
			self.onHandler = onHandler
			self.products = products

			collectionView.reloadData()
		}
	}
}

extension Home.ViewController.ProductsCell: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.products.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let product = products[indexPath.row]

		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: ProductCell.identifier, for: indexPath
		) as? ProductCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: product.imageURL)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let product = products[indexPath.row]
		onHandler?(product)
	}
}

extension Home.ViewController.ProductsCell: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets { .init(top: 0, left: 16, bottom: 0, right: 16) }

	// MARK: - Layout Configuration

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		CGSize(width: 120, height: collectionView.frame.height - 16)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat { 16 }

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat { 0 }

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		scrollDirectionForSectionAt section: Int
	) -> UICollectionView.ScrollDirection { .horizontal }
}

extension Home.ViewController.ProductsCell {
	final class ProductCell: UICollectionViewCell {
		static let identifier = "ProductCell"

		var spotlights: [Home.ViewModel.Product] = []

		// MARK: - UI Properties

		let view: UIView = {
			let view = UIView()
			view.layer.cornerRadius = 16
			view.clipsToBounds = true
			view.backgroundColor = .white
			return view
		}()

		let imageView: UIImageView = {
			let imageView = UIImageView()
			imageView.contentMode = .scaleToFill
			imageView.backgroundColor = .white
			return imageView
		}()

		// MARK: - Initialize

		override init(frame: CGRect) {
			super.init(frame: frame)
			setupUI()
			setupShadow()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		override func prepareForReuse() {
			imageView.image = .imageNotFound
			imageView.accessibilityIdentifier = nil
		}

		// MARK: - Setup UI

		private func setupUI() {
			contentView.addSubview(view)
			view.addSubview(imageView)

			view.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview()
				make.leading.trailing.equalToSuperview()
			}

			imageView.snp.makeConstraints { make in
				make.centerX.centerY.equalToSuperview()
				make.width.height.equalTo(60)
			}
		}

		private func setupShadow() {
			layer.shadowRadius = 4
			layer.shadowOffset = CGSize(width: 0, height: 1.5)
			layer.shadowOpacity = 0.25
			layer.shadowColor = UIColor.black.cgColor

			layer.cornerRadius = 16
			layer.masksToBounds = false
		}

		// MARK: - Configurate

		func configure(with bannerURL: String) {
			// Limpa o estado anterior da célula

			guard let url = URL(string: bannerURL) else {
				imageView.image = .imageNotFound
				return
			}

			// Configura a nova URL
			imageView.load(url: url)
		}

	}
}
