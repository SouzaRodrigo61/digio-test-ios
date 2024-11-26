//
//  DetailSpotlight+HeaderCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 25/11/24.
//

import UIKit
import SnapKit

extension Detail.ViewController {

	// MARK: - HeaderCell
	final class HeaderCell: UITableViewCell {
		static let identifier = "HeaderCell"

		let customImageView: UIImageView = {
			let imageView = UIImageView()
			imageView.contentMode = .scaleAspectFit
			return imageView
		}()

		override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			setupUI()
		}

		required init?(coder: NSCoder) {
			super.init(coder: coder)
			setupUI()
		}

		private func setupUI() {
			contentView.addSubview(customImageView)

			customImageView.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview()
				make.leading.trailing.equalToSuperview()
			}
		}

		func configure(with url: String) {
			guard let url = URL(string: url) else { return }
			customImageView.load(url: url)
		}
	}
}
