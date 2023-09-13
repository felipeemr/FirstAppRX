//
//  ViewController.swift
//  FirstAppRX
//
//  Created by Felipe Moraes Rocha on 23/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    fileprivate var bag = DisposeBag()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let userViewModelInstance = UserViewModel()
    let userList = BehaviorRelay<[UserDetailModel]>(value: [])
    let filteredList = BehaviorRelay<[UserDetailModel]>(value: [])
    var controller: UserDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModelInstance.fetchUserList()
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailController") as UserDetailViewController
        bindUI()
    }
    
    func bindUI() {
        
        userViewModelInstance.userViewModelObserver.subscribe(onNext: { (value) in
            self.filteredList.accept(value)
            self.userList.accept(value)
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)
        
        tableView.tableFooterView = UIView()
        
        filteredList.bind(to: tableView.rx.items(cellIdentifier: "CellIdentifier", cellType: UserCell.self)) { row, model, cell in
            cell.configureCell(userdetail: model)
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.controller?.userDetail.accept(self.filteredList.value[indexPath.row])
            self.controller?.userDetail.value.isFavObservable.subscribe(onNext: { _ in
                self.tableView.reloadData()
            }).disposed(by: self.bag)
            self.navigationController?.pushViewController(self.controller ?? UserDetailViewController(), animated: true)
        }).disposed(by: bag)
        
        Observable.combineLatest(userList.asObservable(),
                                 searchTextField.rx.text,
                                 resultSelector: { users, search in
            return users.filter { (user) -> Bool in
                self.filterUserList(userModel: user, searchText: search)
            }})
            .bind(to: filteredList)
            .disposed(by: bag)
    }
    
    func filterUserList(userModel: UserDetailModel, searchText: String?) -> Bool {
        if let search = searchText, !search.isEmpty, !(userModel.userData.first_name?.contains(search) ?? false) {
            return false
        }
        return true
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

