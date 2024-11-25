//
//  HomeView+SpotlightCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit
import SnapKit

extension Home.ViewController {

	// MARK: - SpotlightCell
	final class SpotlightsCell: UICollectionViewCell {
		static let identifier = "SpotlightsCell"

		var spotlights: [Home.ViewModel.Spotlight] = []

		var onHandler: ((Home.ViewModel.Spotlight) -> Void)?

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

			collectionView.register(SpotlightCell.self,
									forCellWithReuseIdentifier: SpotlightCell.identifier)
		}

		// MARK: - Configurate

		func configure(
			with spotlights: [Home.ViewModel.Spotlight],
			onHandler: @escaping (Home.ViewModel.Spotlight) -> Void
		) {
			self.onHandler = onHandler
			self.spotlights = spotlights

			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
}

extension Home.ViewController.SpotlightsCell: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.spotlights.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let spotlight = spotlights[indexPath.row]

		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: SpotlightCell.identifier, for: indexPath
		) as? SpotlightCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: spotlight.bannerURL)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let spotlight = spotlights[indexPath.row]
		onHandler?(spotlight)
	}
}

extension Home.ViewController.SpotlightsCell: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets { .init(top: 16, left: 16, bottom: 16, right: 16) }

	// MARK: - Layout Configuration

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height - 16)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat { 8 }

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

extension Home.ViewController.SpotlightsCell {
	final class SpotlightCell: UICollectionViewCell {
		static let identifier = "SpotlightCell"

		var spotlights: [Home.ViewModel.Spotlight] = []

		// MARK: - UI Properties

		let imageView: UIImageView = {
			let imageView = UIImageView()
			imageView.contentMode = .scaleAspectFill
			imageView.layer.cornerRadius = 16
			imageView.clipsToBounds = true
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

		// MARK: - Setup UI

		private func setupUI() {
			contentView.addSubview(imageView)

			imageView.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview()
				make.leading.trailing.equalToSuperview()
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
			guard let url = URL(string: bannerURL) else { return }
			imageView.load(url: url)
		}
	}
}
