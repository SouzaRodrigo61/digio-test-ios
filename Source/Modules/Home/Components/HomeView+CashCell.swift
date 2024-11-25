//
//  HomeView+CashCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit

extension Home.ViewController {

	// MARK: - CashCell
	final class CashCell: UICollectionViewCell {
		static let identifier = "CashCell"

		private var cash: Home.ViewModel.Cash?
		var onHandler: ((Home.ViewModel.Cash) -> Void)?

		let imageView: UIImageView = {
			let imageView = UIImageView()
			imageView.contentMode = .scaleAspectFill
			imageView.layer.cornerRadius = 16
			imageView.clipsToBounds = true
			return imageView
		}()

		override init(frame: CGRect) {
			super.init(frame: frame)
			setupUI()
			setupShadow()
			setupGesture()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

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

		private func setupGesture() {
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
			tapGesture.numberOfTapsRequired = 1 // Define o número de toques necessários
			addGestureRecognizer(tapGesture)
		}

		@objc private func handleTapGesture() {
			guard let cash = cash else { return }
			onHandler?(cash)
		}

		func configure(
			with cash: Home.ViewModel.Cash,
			onHandler: @escaping (Home.ViewModel.Cash) -> Void
		) {
			self.onHandler = onHandler
			self.cash = cash
			guard let url = URL(string: cash.bannerURL) else { return }
			imageView.load(url: url)
		}
	}
}
