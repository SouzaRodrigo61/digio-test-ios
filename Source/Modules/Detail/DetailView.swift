//
//  DetailSpotlightView.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 25/11/2024.
//

import UIKit
import SnapKit

extension Detail {
    final class ViewController: UIViewController {

        private var viewModel: ViewModel

		private lazy var tableView: UITableView = {
			let tableView = UITableView(frame: .zero, style: .plain)
			tableView.showsHorizontalScrollIndicator = false
			tableView.showsVerticalScrollIndicator = false

			tableView.separatorStyle = .none // Remove as linhas separadoras
			tableView.estimatedRowHeight = 44 // Altura estimada para células automáticas
			tableView.rowHeight = UITableView.automaticDimension
			return tableView
		}()

        init(viewModel: ViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
			self.navigationController?.isNavigationBarHidden = false
			self.navigationItem.title = "Detalhe"

			setupUI()
			setupTableView()
        }

		// MARK: - Setup UI

		private func setupUI() {
			view.addSubview(tableView)

			tableView.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview()
				make.leading.trailing.equalToSuperview()
			}

			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}

		private func setupTableView() {
			tableView.delegate = self
			tableView.dataSource = self

			tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
			tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
			tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
		}
    }
}

extension Detail.ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.sections.row.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = viewModel.sections.row[indexPath.row]

		switch row {
		case .bannerURL(let value):
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: HeaderCell.identifier, for: indexPath
			) as? HeaderCell else {
				return UITableViewCell()
			}
			cell.configure(with: value)
			return cell
		case .name(let value):
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: TitleCell.identifier, for: indexPath
			) as? TitleCell else {
				return UITableViewCell()
			}
			cell.configure(with: value)
			return cell
		case .description(let value):
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: DescriptionCell.identifier, for: indexPath
			) as? DescriptionCell else {
				return UITableViewCell()
			}
			cell.configure(with: value)
			return cell
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let row = viewModel.sections.row[indexPath.row]
		switch row {
		case .bannerURL:
			return 120
		default:
			return UITableView.automaticDimension
		}
	}
}
