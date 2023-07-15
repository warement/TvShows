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

struct Section {
    
    let sectionName: String
    let tvShows: [TvShowsDTO]
    
    internal init(sectionName: String, tvShows: [TvShowsDTO]) {
        self.sectionName = sectionName
        self.tvShows = tvShows
    }
}

class TvShowsLandingVC: UIViewController {
    private enum ConstIdentifiers {
        static let reusableCollectionViewCell = "ReusableCollectionViewCell"
        static let collectionViewHeader = "CollectionViewReusableViewHeader"
    }
    @IBOutlet weak var tvShowsCV: UICollectionView!
    
    
    
    private var viewModel: TvShowsLandingViewModel
       
    private var sections: [Section] = []
    
    let disposeBag = DisposeBag()
    
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
        //tvShowsCV.reloadData()
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
        tvShowsCV.dataSource = self
        tvShowsCV.delegate = self
        //tvShowsCV.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    }
    
    func setupObservers() {
        self.viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] tvShows in
                print("....popular: \(tvShows.popularTvShows.count), topRated: \(tvShows.topRatedTvShows.count), onTheAir: \(tvShows.onTheAirTvShows.count).....")
                self?.sections = [
                    Section(sectionName: "Popular", tvShows: tvShows.popularTvShows),
                    Section(sectionName: "Top Rated", tvShows: tvShows.topRatedTvShows),
                    Section(sectionName: "On The Air", tvShows: tvShows.onTheAirTvShows)
                ]
                self?.tvShowsCV.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Collection View Delegate & DataSource
extension TvShowsLandingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstIdentifiers.reusableCollectionViewCell, for: indexPath) as? ReusableCollectionViewCell else { fatalError("DequeueReusableCell failed while casting") }
        let tvShow = sections[indexPath.section].tvShows[indexPath.row]
        cell.setup(tvShow: tvShow)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ConstIdentifiers.collectionViewHeader,
            for: indexPath
        ) as? CollectionViewReusableViewHeader
        else {
            fatalError("Header for reuse identifier \(ConstIdentifiers.collectionViewHeader) NOT FOUND!!")
        }
        let sectionName = sections[indexPath.section].sectionName

        headerView.setupView(title: sectionName)

        return headerView
    }
}

extension TvShowsLandingVC: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Return the size of your collection view cells
            return CGSize(width: 143, height: 283)
        }
}
