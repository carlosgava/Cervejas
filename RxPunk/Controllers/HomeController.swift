//
//  HomeController.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/23/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import struct RxCocoa.Driver
import RxDataSources
import RxSwiftUtilities
import protocol RxSwift.ImmediateSchedulerType
import class RxSwift.Observable
import class RxSwift.SerialDispatchQueueScheduler
import class UIKit.UITableView
import class UIKit.UIViewController

final class HomeController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Rx

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>>()

    // MARK: Lazy variables

    lazy var api: PunkAPI = {
        let backgroundWorker = SerialDispatchQueueScheduler(qos: .background)
        let itemsPerPage = 25
        let reachabilityService = try! DefaultReachabilityService()
        let urlSession = URLSession.shared

        return DefaultPunkAPI(backgroundWorker: backgroundWorker, itemsPerPage: itemsPerPage,
                              reachabilityService: reachabilityService, urlSession: urlSession)
    }()
}

// MARK: UIViewController functions

extension HomeController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        setupRx()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let beer = sender as? Beer, let controller = segue.destination as? DetailController {
            controller.set(beer: beer)
        }
    }
}

// MARK: UITableViewDelegate conforms

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: Private functions

private extension HomeController {
    func setupDataSource() {
        dataSource.configureCell = { (_, tableView, indexPath, beer) in
            let id = String(describing: BeerCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! BeerCell

            cell.setup(beer: beer)

            return cell
        }

        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            let count = dataSource.sectionModels[indexPath].items.count
            let hasItems = count > 0

            return hasItems ? "Cervejas (\(count))" : "Cervejas não encontradas"
        }
    }

    func setupRx() {
        let tableView: UITableView = self.tableView
        let api: PunkAPI = self.api
        let activityIndicator = ActivityIndicator()

        let searchTrigger = searchBar.rx.text.orEmpty.asDriver().throttle(0.35)

        let loadNextPageTrigger: (Driver<PunkBeersState>) -> Driver<Void> = { state in
            tableView.rx.contentOffset.asDriver().withLatestFrom(state).flatMapLatest({ state in
                return tableView.isNearBottomEdge && !state.shouldLoadNextPage ? Driver.just() : Driver.empty()
            })
        }

        let performRequest: (URL) -> Observable<GetBeersResponse> = { url in
            return api.getBeers(at: url).trackActivity(activityIndicator)
        }

        let input = HomeViewModel.Input(searchTrigger: searchTrigger, nextPageTrigger: loadNextPageTrigger, performRequest: performRequest)
        let viewModel = HomeViewModel(input: input, api: api)

        viewModel.state.map({ $0.beers }).distinctUntilChanged()
            .map({ [SectionModel(model: "Beers", items: $0.value)] })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)

        tableView.rx.modelSelected(Beer.self).asDriver()
            .map({ StoryboardSegue.showDetail($0) })
            .drive(rx.performSegue)
            .disposed(by: rx.disposeBag)

        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)

        activityIndicator.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: rx.disposeBag)
    }
}
