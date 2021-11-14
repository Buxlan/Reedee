//
//  CollectionViewBaseVC.swift
//  BubbleComics
//
//  Created by Azov Vladimir on 18/11/2019.
//  Copyright © 2019 Bubble. All rights reserved.
//

import UIKit

final class CollectionViewBase: NSObject {
    private var dataSource: CollectionDataSource

    init(dataSource: CollectionDataSource = CollectionDataSource()) {
        self.dataSource = dataSource
    }

    func updateDataSource(_ dataSource: CollectionDataSource) {
        self.dataSource = dataSource
    }

    func setupCollection(_ collection: UICollectionView) {
        collection.delegate = self
        collection.dataSource = self
    }

    func rowFromIndexPath(_ indexPath: IndexPath) -> CollectionRow {
        return dataSource.rowFromIndexPath(indexPath)
    }
}

extension CollectionViewBase: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = dataSource.rowFromIndexPath(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.rowId, for: indexPath)
        row.config.configure(view: cell)
        return cell
    }
}

extension CollectionViewBase: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let section = dataSource.sections[indexPath.section]

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let sectionHeaderId = section.headerViewId {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: sectionHeaderId,
                    for: indexPath)
                section.headerConfig.configure(view: view)
                return view
            }
        case UICollectionView.elementKindSectionFooter:
            if let sectionFooterId = section.headerViewId {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: sectionFooterId,
                    for: indexPath)
                section.footerConfig.configure(view: view)
                return view
            }
        default:
            break
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource.rowFromIndexPath(indexPath).action()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        dataSource.rowFromIndexPath(indexPath).deselectAction()
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.section < dataSource.sections.count,
              indexPath.row < dataSource.sections[indexPath.section].rows.count else {
            return
        }
        dataSource.rowFromIndexPath(indexPath).willDisplay()
    }

    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.section < dataSource.sections.count,
              indexPath.row < dataSource.sections[indexPath.section].rows.count else {
            return
        }
        dataSource.rowFromIndexPath(indexPath).endDisplay()
    }
}

extension CollectionViewBase: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return dataSource.sections[section].headerSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return dataSource.sections[section].footerSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return dataSource.sections[section].lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.rowFromIndexPath(indexPath).size
    }
}
