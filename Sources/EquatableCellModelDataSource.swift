//
//  CellModelManager.swift
//  Example
//
//  Created by Petr Zvoníček on 08.06.18.
//  Copyright © 2018 FUNTASTY Digital, s.r.o. All rights reserved.
//

import UIKit

public class EquatableCellModelDataSource: AbstractDataSource, DataSource {

    public var sections: [EquatableCellModelSection] {
        get {
            return diffCalculator.sectionedValues.sections
        }
        set {
            diffCalculator.sectionedValues = SectionedValues(newValue.map { ($0, $0.cells.map { $0.asEquatable() }) })
        }
    }    

    public var first: EquatableCellModelSection? {
        return diffCalculator.sectionedValues.sections.first
    }

    let diffCalculator: AbstractDiffCalculator<EquatableCellModelSection, AnyEquatableCellModel>

    public init(_ tableView: UITableView, sections: [EquatableCellModelSection]) {
        self.diffCalculator = TableViewDiffCalculator(tableView: tableView)
        super.init()

        self.sections = sections
    }

    public init(_ collectionView: UICollectionView, sections: [EquatableCellModelSection]) {
        self.diffCalculator = CollectionViewDiffCalculator(collectionView: collectionView)
        super.init()

        self.sections = sections
    }

    public subscript(index: Int) -> EquatableCellModelSection {
        return diffCalculator.sectionedValues.sections[index]
    }

    public override func sectionsCount() -> Int {
        return self.diffCalculator.numberOfSections()
    }

    public override func cellModels(in section: Int) -> [CellModel] {
        return self.diffCalculator.value(forSection: section).cells
    }

    public override func header(in section: Int) -> SupplementaryViewModel? {
        return self.diffCalculator.value(forSection: section).headerView
    }

    public override func footer(in section: Int) -> SupplementaryViewModel? {
        return self.diffCalculator.value(forSection: section).footerView
    }

    public override func cellModel(at indexPath: IndexPath) -> CellModel {
        return self.diffCalculator.value(atIndexPath: indexPath)
    }
}
