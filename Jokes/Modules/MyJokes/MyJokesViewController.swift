//
//  MyJokesViewController.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit
import PromiseKit

class MyJokesViewController: UITableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My jokes"
        
        tableView.separatorStyle = .none
        tableView.register(JokeCell.self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJokes()
        fetchUser()
    }
    
    var crud: CRUDService<JokeCRUDModel> = crudService()
    var userCrud: CRUDService<UserCRUDModel> = crudService()
    
    private var joke: JokeCRUDModel?
    private var user: UserCRUDModel? {
        didSet { tableView.reloadData() }
    }
    
    var models = [JokeListSection]() {
        didSet { tableView.reloadData() }
    }
    
    @objc private func addTapped() {
        let controller = CreateJokeViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        controller.saveClosure = {[unowned self] in
            self.fetchJokes()
        }
        
        present(controller, animated: true, completion: nil)
    }
}

// MARK: - UITAbleViewDatasource

extension MyJokesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count != 0 ? models[section].items.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        switch models[indexPath.section].items[indexPath.row] {
        case let .joke(_, joke, isLike, shareAction, likeAction, deleteAction):
            cell = (tableView.dequeue(for: indexPath) as JokeCell).then {
                $0.jokeText = UserInfo.shared.offlineMode ? joke?.replacingOccurrences(of: "Chuck Norris", with: (self.user?.firstname ?? "") + " " + (self.user?.lastname ?? "")) : joke
                $0.shareButtonTapped = shareAction
                $0.isLike = isLike
                $0.likeButtonTapped = likeAction
                $0.deleteButtonTapped = deleteAction
                $0.isJokeList = false
            }
        }
        
        return cell
    }
}


private extension MyJokesViewController {

    func deleteJoke() {
        guard var joke = joke else { return }
        joke.isLike = false
        
        firstly {
            crud.update([joke])
        }.done {
            self.fetchJokes()
        }.catch {
            print($0)
        }
    }
    
    func fetchUser() {
        firstly {
            userCrud.read()
        }.compactMap {
            $0.first
        }.done {
            self.user = $0
        }.catch {
            print($0)
        }
    }
    
    func fetchJokes() {
        firstly {
            crud.read(.isLike)
        }.done {
            var model = [JokeListItem]()
            
            model = $0.map { joke in .joke(id: Int(joke.id),
                                           joke: joke.joke,
                                           isLike: joke.isLike ?? false,
                                           shareAction: {},
                                           likeAction: {},
                                           deleteAction: { [unowned self] in
                                            self.joke = joke
                                            self.deleteJoke()
                                           })
                
            }
            
            self.models = [.init(header: "", items: model)]
        }.catch {
            print($0)
        }
    }
}
