//
//  BaseModel.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation

import SwiftyJSON

class BaseModel: NSObject {

    public override init() {
        super.init()
    }
    
    required public init(json: JSON) {
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func getArray<T: BaseModel>(json: JSON) -> [T] {
        
        var result: [T] = []
        let items = json.arrayValue
        for i in items {
            let model = T(json: i)
            result.append(model)
        }
        
        return result
    }
}
