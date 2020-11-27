//
//  JokeListViewController.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit
import PromiseKit

class JokeListViewController: UITableViewController {
    
    var httpProvider = HTTPProvider<JokeRequest>()
    var crud: CRUDService<JokeCRUDModel> = crudService()
    
    private var joke: JokeCRUDModel? {
        didSet { }//likeJoke() }
    }
    
    var models = [JokeListSection]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Joke list"
        
        tableView.separatorStyle = .none
        tableView.register(JokeCell.self)
        
        if !UserInfo.shared.offlineMode {
            firstly {
                httpProvider.dataRequest(.init(apiMethod: .jokelist))
            }.compactMap {
                try JSONDecoder().decode(JokeListModel.self, from: $0)
            }.done {
                $0.value.forEach { joke in self.crud.create([joke])}
                self.fetchJokes()
            }.catch {
                print($0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserInfo.shared.offlineMode {
            randomJoke()
        } else {
            fetchJokes()
        }
    }
}

// MARK: - UITAbleViewDatasource

extension JokeListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count != 0 ? models[section].items.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        switch models[indexPath.section].items[indexPath.row] {
        case let .joke(_, joke, isLike, shareAction, likeAction, deleteAction):
            cell = (tableView.dequeue(for: indexPath) as JokeCell).then {
                $0.jokeText = joke
                $0.shareButtonTapped = shareAction
                $0.isLike = isLike
                $0.likeButtonTapped = likeAction
                $0.deleteButtonTapped = deleteAction
            }
        }
        
        return cell
    }
}


private extension JokeListViewController {
    
    func shareJoke(_ joke: String?) {
        let textToShare = [ joke ?? "" ]
        
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func likeJoke() {
        guard var joke = joke else { return }
        
        joke.isLike =  (joke.isLike ?? false) ? false : true
        
        firstly {
            crud.update([joke])
        }.done {
            if UserInfo.shared.offlineMode {
                self.randomJoke()
            } else {
                self.fetchJokes()
            }
        }.catch {
            print($0)
        }
    }
    
    func fetchJokes() {
        firstly {
            crud.read(.all)
        }.done {
            var model = [JokeListItem]()
            model = $0.map { joke in .joke(id: Int(joke.id),
                                           joke: joke.joke,
                                           isLike: joke.isLike ?? false,
                                           shareAction: { [unowned self] in self.shareJoke(joke.joke) },
                                           likeAction: { [unowned self] in
                                            self.joke = joke
                                            self.likeJoke()
                },
                                           deleteAction: {})
                
            }
            
            self.models = [.init(header: "", items: model)]
        }.catch {
            print($0)
        }
    }
    
    func randomJoke() {
        firstly {
            crud.read()
        }.compactMap {
            $0[Int.random(in: 0..<$0.count)]
        }.done { joke in
            var item = [JokeListItem]()
            
            item = [.joke(id: Int(joke.id),
                          joke: joke.joke,
                          isLike: joke.isLike ?? false,
                          shareAction: { [unowned self] in self.shareJoke(joke.joke) },
                          likeAction: { [unowned self] in
                            self.joke = joke
                            self.likeJoke()
                },
                          deleteAction: {})]
            
            self.models = [.init(header: "", items: item)]
        }.catch {
            print($0)
        }
    }
}

extension JokeListViewController {
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if UserInfo.shared.offlineMode {
            randomJoke()
        } else {
            fetchJokes()
        }
    }
}
