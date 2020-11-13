//
//  Extensions.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

extension UIView {
    class func construct<T: UIView>(builder: (() -> Void) = { }) -> T {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        builder()
        return view
    }
}

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
