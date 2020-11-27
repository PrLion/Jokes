//
//  SettingsViewController.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit
import PromiseKit

class SettingsViewController: UITableViewController {
    // MARK: - Properties
    
    var models = [SettingsSection]() {
        didSet { tableView.reloadData() }
    }
    
    var crud: CRUDService<UserCRUDModel> = crudService()
    private var user: UserCRUDModel? {
        didSet { saveUserInfo() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        tableView.register(TextFieldCell.self)
        tableView.register(SwitchableCell.self)
        
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.saveUserInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
    
}

// MARK: - UITAbleViewDatasource

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count != 0 ? models[section].items.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        switch models[indexPath.section].items[indexPath.row] {
        case let .textfield(placeholder, text, textAction):
            cell = (tableView.dequeue(for: indexPath) as TextFieldCell).then {
                $0.placeholder = placeholder
                $0.textValue = text
                $0.textChanged = textAction
            }
        case let .switchable(title, state, action):
            cell = (tableView.dequeue(for: indexPath) as SwitchableCell).then {
                $0.title = title
                $0.state = state
                $0.switchAction = action
            }
        }
        
        return cell
    }
}


private extension SettingsViewController {
    func configureModel(model: UserCRUDModel?) {
        models = [ .init(items: [
            .textfield(placeholder: "Character firstname", text: (model?.firstname ?? ""), textAction: { self.user?.firstname = $0 }),
            .textfield(placeholder: "Character lastname", text: (model?.lastname ?? ""), textAction: { self.user?.lastname = $0 }),
            .switchable(title: "offlineMode", state: UserInfo.shared.offlineMode, action: { UserInfo.shared.offlineMode = $0 })
            ])
        ]
    }
    
    func saveUserInfo() {
        if user == nil {
            user = UserCRUDModel(with: .init(context: .init(concurrencyType: .privateQueueConcurrencyType)))
            user?.id = Int32(1)
        }
        guard let user = user else { return }
        firstly {
            crud.read()
        }.done {
            if $0.first != nil {
                firstly {
                    self.crud.update([user])
                }.catch {
                    print($0)
                }
            } else {
                firstly {
                    self.crud.create([user])
                }.done{
                    self.fetchUser()
                }.catch {
                    print($0)
                }
            }
        }.catch {
            print($0)
        }
    }
    
    func fetchUser() {
        firstly {
            crud.read()
        }.compactMap {
            $0.first
        }.done {
            self.user = $0
            self.configureModel(model: $0)
        }.catch {
            print($0)
        }
    }
}
