//
//  Sq+Extension.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 1.11.2021.
//

import Foundation

extension Sequence where Element: Hashable {

    func unique() -> Set<Element> {
        var uniques = Set<Element>()
        for item in self {
            uniques.insert(item)
        }
        return uniques
    }
}

//func test(){
//    let numbers = [1, 1, 3, 9, 22, 3, 4, 5, 22, 9]
//    print(numbers.unique())
//}
