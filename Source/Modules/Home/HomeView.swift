//
//  HomeView.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 22/11/2024.
//

import UIKit
import SnapKit

extension Home {
	final class ViewController: UIViewController {

		// MARK: - ViewModel

		private var viewModel: ViewModel

		// MARK: - Properties UI

		lazy var collectionView: UICollectionView = {
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .vertical
			return UICollectionView(frame: .zero, collectionViewLayout: layout)
		}()

		// MARK: - Init

		init(viewModel: ViewModel) {
			self.viewModel = viewModel
			super.init(nibName: nil, bundle: nil)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		// MARK: - Lifecycle

		override func viewDidLoad() {
			super.viewDidLoad()
			view.backgroundColor = .white
			setupUI()
			setupDelegate()
			setupCollectionView()

			DispatchQueue.global(qos: .background).async { [weak self] in
				guard let self else { return }
				viewModel.fetchProducts { [weak self] result in
					guard let self else { return }
					switch result {
					case .success:
						DispatchQueue.main.async {
							self.collectionView.reloadData()
						}
					case .failure(let error):
						dump(error, name: "Error")
					}
				}
			}
		}

		// MARK: - Setup

		private func setupUI() {
			view.addSubview(collectionView)
			collectionView.snp.makeConstraints { make in
				make.edges.equalToSuperview()
			}
		}

		private func setupDelegate() {
			collectionView.delegate = self
			collectionView.dataSource = self
		}

		private func setupCollectionView() {
			collectionView.register(SpotlightsCell.self,
									forCellWithReuseIdentifier: SpotlightsCell.identifier)
			collectionView.register(ProductsCell.self,
									forCellWithReuseIdentifier: ProductsCell.identifier)
			collectionView.register(CashCell.self,
									forCellWithReuseIdentifier: CashCell.identifier)
			collectionView.register(
				SectionHeaderView.self,
				forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
				withReuseIdentifier: SectionHeaderView.identifier
			)
		}

		// MARK: - Control Section

		// MARK: - Gestures
	}
}

// MARK: - DataSource
extension Home.ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		viewModel.sections.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		let isHorizontalSection = viewModel.sections[section].isHorizontal
		return isHorizontalSection ? 1 : viewModel.sections[section].row.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let section = viewModel.sections[indexPath.section]
		let row = section.row[indexPath.row]

		switch row {
		case .spotlight(let spotlight):
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: SpotlightsCell.identifier, for: indexPath
			) as? SpotlightsCell else {
				return UICollectionViewCell()
			}
			cell.configure(with: spotlight) { [weak self] spotlight in
				guard let self else { return }
				dump(spotlight, name: "spotlight")
			}
			return cell
		case .products(let product):
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: ProductsCell.identifier, for: indexPath
			) as? ProductsCell else {
				return UICollectionViewCell()
			}
			cell.configure(with: product) { [weak self] product in
				guard let self else { return }
				dump(product, name: "product")
			}
			return cell
		case .cash(let cash):
			guard let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: CashCell.identifier, for: indexPath
			) as? CashCell else {
				return UICollectionViewCell()
			}
			cell.configure(with: cash) { [weak self] cash in
				guard let self else { return }
				dump(cash, name: "cash")
			}
			return cell
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		let hasTitle = viewModel.sections[section].title != nil
		return hasTitle ? CGSize(width: collectionView.frame.width, height: 40) : .zero
	}

	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		guard kind == UICollectionView.elementKindSectionHeader else {
			fatalError("Unsupported kind: \(kind)")
		}

		guard let header = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: SectionHeaderView.identifier,
			for: indexPath
		) as? SectionHeaderView else {
			return UICollectionReusableView()
		}

		let section = viewModel.sections[indexPath.section]
		header.configure(with: section.title)

		return header
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension Home.ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets { .init(top: 0, left: 4, bottom: 0, right: 4) }

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let section = viewModel.sections[indexPath.section]
		let row = section.row[indexPath.row]

		switch row {
		case .spotlight:
			return CGSize(width: collectionView.frame.width, height: 180)
		case .cash:
			return CGSize(width: collectionView.frame.width - 32, height: 100)
		case .products:
			return CGSize(width: collectionView.frame.width, height: 120)
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat { 0 }

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat { 0 }
}
