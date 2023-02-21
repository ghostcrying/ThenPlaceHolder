//
//  ThenWeaker.swift
//  ThenPlaceHolder
//
//  Created by ghost on 2023/1/6.
//

import Foundation

class WeakObjectContainer: NSObject {
    
    weak var weakObject: AnyObject?
    
    init(with weakObject: Any?) {
        super.init()
        self.weakObject = weakObject as AnyObject?
    }
}
