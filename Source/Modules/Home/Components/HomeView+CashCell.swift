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

		func configure(with cash: Home.ViewModel.Cash) {
			guard let url = URL(string: cash.bannerURL) else { return }
			imageView.load(url: url)
		}
	}
}
