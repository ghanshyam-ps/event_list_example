//
//  Theme.swift
//  SeatGeekEvents
//
//  Created by Ghanshyam Bhesaniya on 03/06/22.
//

import UIKit

protocol ColorPackage {
    var tabbarBackground: UIColor { get }
    var tabbarText: UIColor { get }
    var tabbarTint: UIColor { get }
    var viewBackground: UIColor { get }
    var taskCellBackground: UIColor { get }
    var taskCellVerticalLine: UIColor { get }
    var taskCellActiveCircle: UIColor { get }
    var taskCellInactiveCircle: UIColor { get }
    var taskCellTitle: UIColor { get }
    var taskCellTime: UIColor { get }
    var taskCellDoneButton: UIColor { get }
    var taskCellTickImage: UIColor { get }
    var taskCellCoverView: UIColor { get }
    var detailCellBackground: UIColor { get }
    var detailCellText: UIColor { get }
}

// MARK: - App Theme
extension App {
    enum Theme {
        case dark
        case light

        static var current: Theme = .dark

        var package: ColorPackage {
            switch self {
            case .light:
                return NightPackage()
            case .dark:
                return NightPackage()
            }
        }
    }

    struct NightPackage: ColorPackage {
        var tabbarBackground: UIColor = UIColor(hex: 0x181818)
        var tabbarText: UIColor = UIColor(hex: 0x7f7f7f)
        var tabbarTint: UIColor = UIColor(hex: 0xff9500)
        var viewBackground: UIColor = UIColor(hex: 0x0d0d0d)
        var taskCellBackground: UIColor = UIColor(hex: 0x201f25)
        var taskCellActiveCircle: UIColor = UIColor(hex: 0xff9500)
        var taskCellInactiveCircle: UIColor = UIColor(hex: 0x34333b)
        var taskCellVerticalLine: UIColor = UIColor(hex: 0x34333b)
        var taskCellTitle: UIColor = UIColor(hex: 0xffffff)
        var taskCellTime: UIColor = UIColor(hex: 0x919093)
        var taskCellDoneButton: UIColor = UIColor(hex: 0x919093)
        var taskCellTickImage: UIColor = UIColor(hex: 0x201f25)
        var taskCellCoverView: UIColor = UIColor(hex: 0x000000, transparency: 0.6)
        var detailCellBackground: UIColor = UIColor(hex: 0x171717)
        var detailCellText: UIColor = UIColor(hex: 0xffffff)
    }
}
