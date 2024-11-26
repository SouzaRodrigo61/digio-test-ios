//
//  DetailSpotlight+HeaderCell.swift
//  Digio
//
//  Created by Rodrigo Souza on 25/11/24.
//

import UIKit

extension Detail.ViewController {

	// MARK: - TitleCell
	final class TitleCell: UITableViewCell {
		static let identifier = "TitleCell"

		let label: UILabel = {
			let label = UILabel()
			label.font = .systemFont(ofSize: 24, weight: .semibold)
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
				make.top.equalToSuperview().offset(8)
				make.bottom.equalToSuperview().offset(-8)
				make.leading.equalToSuperview().offset(16)
				make.trailing.equalToSuperview().offset(-16)
			}
		}

		func configure(with value: String) {
			label.text = value
		}
	}
}
