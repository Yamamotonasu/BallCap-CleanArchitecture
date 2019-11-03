//
//  TestThreeViewController.swift
//  Test4
//
//  Created by 山本裕太 on 2019/10/20.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TestThreeViewController: UIViewController {
    
    // MARK: - ViewModel

    private var viewModel: TestThreeViewModel!
    
    // MARK: - Properties, Outlets

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: configureCell)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, _) in
        let item = dataSource[indexPath]
        switch item {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accessryType
            return cell
        case .description(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupViewModel()
    }

}

// MARK: - Private Functions

extension TestThreeViewController {
    
    private func setupViewController() {
        navigationItem.title = "設定"
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let item = self?.dataSource[indexPath] else { return }
            self?.tableView.deselectRow(at: indexPath, animated: true)
            switch item {
            case .account:
                break
            case .security:
                break
            case .notification:
                break
            case .contents:
                break
            case .sounds:
                break
            case .dataUsing:
                break
            case .accessibility:
                break
            case .description:
                break
            }
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = TestThreeViewModel()
        viewModel.itemsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        viewModel.updateItems()
    }

}

extension TestThreeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }

}

