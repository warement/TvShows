//
//  TvShowsLandingVC.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources

class TvShowsLandingVC: UIViewController {
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var tvShowsCV: UICollectionView!
    
    private var viewModel: TvShowsLandingViewModel
    private enum ConstIdentifiers {
        static let reusableCollectionViewCell = "ReusableCollectionViewCell"
        static let collectionViewHeader = "CollectionViewReusableViewHeader"
    }
        
    init(viewModel: TvShowsLandingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onTriggeredEvent(event: .fetchData)
        setupCollectionView()
        setCardsLayout()
        setupObservers()
        headerTitleLbl.attributedText = "Tv Shows".with(.title1(weight: .BOLD, color: .tintPrimary))
    }
    
    // MARK: - Setup Collection View
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        var absoluteWidth: CGFloat = 0
        var absoluteHeight: CGFloat = 0
        
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                absoluteWidth = 256
                absoluteHeight = 384
            default:
                absoluteWidth = 150
                absoluteHeight = 225
            }
            
            let inset: CGFloat = 8
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(absoluteWidth), heightDimension: .absolute(absoluteHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(absoluteWidth), heightDimension: .absolute(absoluteHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            section.orthogonalScrollingBehavior = .continuous
            
            // Supplementary Item
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [headerItem]
            
            return section
        })
        return compositionalLayout
    }
    
    private func setCardsLayout() {
        let layout = getCompositionLayout()
        tvShowsCV.collectionViewLayout = layout
    }

    func setupCollectionView() {
        tvShowsCV.register(
            UINib(
                nibName: ConstIdentifiers.collectionViewHeader,
                bundle: Bundle(for: CollectionViewReusableViewHeader.self)),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ConstIdentifiers.collectionViewHeader)
        
        tvShowsCV.register(
            UINib(
                nibName: ConstIdentifiers.reusableCollectionViewCell,
                bundle: Bundle(for: type(of: self))),
            forCellWithReuseIdentifier: ConstIdentifiers.reusableCollectionViewCell
        )
    }
    
    func setupObservers() {
        let tvShowsDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, TvShows>> { [weak self] dataSource, collectionView, indexPath, item in
            guard let cell = self?.tvShowsCV.dequeueReusableCell(
                withReuseIdentifier: ConstIdentifiers.reusableCollectionViewCell,
                for: indexPath) as? ReusableCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.setup(tvShow: item)
            return cell
        } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ConstIdentifiers.collectionViewHeader,
                for: indexPath
            ) as? CollectionViewReusableViewHeader
            else { return UICollectionReusableView() }
            
            headerView.setupView(title: dataSource[indexPath.section].model)
            return headerView
        }
        
        viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .map { $0.tvShowsDisplayable }
            .distinctUntilChanged()
            .bind(to: tvShowsCV.rx.items(dataSource: tvShowsDataSource))
            .disposed(by: rx.disposeBag)
        
        tvShowsCV.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .map { indexPath in
                return tvShowsDataSource[indexPath]
            }
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.onTriggeredEvent(event: .getTvShowDetails(id: item.id?.description ?? ""))
            }).disposed(by: rx.disposeBag)
    }
}
