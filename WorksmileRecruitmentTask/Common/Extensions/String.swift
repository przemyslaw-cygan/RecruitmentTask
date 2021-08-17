//
//  String.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

enum StringCastingError: Error {
    case unableToCastToDoble(stringValue: String)
    case unableToCastToInt(stringValue: String)
}

extension String {
    func asDouble() throws -> Double {
        guard let value = Double(self) else { throw StringCastingError.unableToCastToDoble(stringValue: self) }
        return value
    }

    func asInt() throws -> Int {
        guard let value = Int(self) else { throw StringCastingError.unableToCastToInt(stringValue: self) }
        return value
    }
}
