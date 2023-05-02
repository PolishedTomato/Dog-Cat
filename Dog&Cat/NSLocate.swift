//
//  NSLocate.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/1/23.
//

import Foundation

extension NSLocale{
    class func countryNameToCountrycode(for fullCountryName : String) -> String {
        var locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode as! String
            }
        }
        return locales.lowercased()
    }
}
