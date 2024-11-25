//
//  HomeView+A.swift
//  Digio
//
//  Created by Rodrigo Souza on 24/11/24.
//

import UIKit

extension Home.ViewController {
	final class SectionHeaderView: UICollectionReusableView {
		static let identifier = "SectionHeaderView"

		private let titleLabel = UILabel()

		override init(frame: CGRect) {
			super.init(frame: frame)
			setupUI()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func setupUI() {
			addSubview(titleLabel)

			titleLabel.numberOfLines = 0

			titleLabel.snp.makeConstraints { make in
				make.leading.equalToSuperview().offset(16)
				make.trailing.equalToSuperview().offset(-16)
				make.top.bottom.equalToSuperview()
			}
		}

		func configure(with title: NSAttributedString?) {
			titleLabel.attributedText = title
		}
	}
}
