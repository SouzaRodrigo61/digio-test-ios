//
//  DetailSpotlight+DescriptionCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 25/11/24.
//

import UIKit
import SnapKit

extension Detail.ViewController {

	// MARK: - DescriptionCell
	final class DescriptionCell: UITableViewCell {
		static let identifier = "DescriptionCell"

		let label: UILabel = {
			let label = UILabel()
			label.font = .systemFont(ofSize: 16, weight: .medium)
			label.numberOfLines = 0
			label.textColor = .black
			return label
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
			contentView.addSubview(label)

			label.snp.makeConstraints { make in
				make.top.equalToSuperview()
				make.bottom.equalToSuperview()
				make.leading.equalToSuperview().offset(16)
				make.trailing.equalToSuperview().offset(-16)
			}
		}

		func configure(with value: String) {
			label.text = value
		}
	}
}
