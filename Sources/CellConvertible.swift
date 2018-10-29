//
//  CellConvertible.swift
//  CellKit-iOS
//
//  Created by Petr Zvoníček on 08.06.18.
//  Copyright © 2018 FUNTASTY Digital, s.r.o. All rights reserved.
//

public protocol CellConvertible: ReusableView {
    associatedtype Cell: CellConfigurable
}

public extension CellConvertible {
    var cellClass: AnyClass {
        return Cell.self
    }
}

public extension CellConvertible where Self == Cell.Model {
    func configure(cell: AnyObject) {
        if let cell = cell as? Cell {
            cell.configure(with: self)
        } else {
            assertionFailure("Wrong cell type \(type(of: cell)) provided for configuration to \(type(of: self))'!")
        }
    }
}
