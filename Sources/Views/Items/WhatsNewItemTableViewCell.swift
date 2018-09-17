//
//  WhatsNewItemTableViewCell.swift
//  WhatsNewKit
//
//  Created by Sven Tiigi on 19.05.18.
//  Copyright © 2018 WhatsNewKit. All rights reserved.
//

import UIKit

/// The WhatsNewItemTableViewCell
class WhatsNewItemTableViewCell: UITableViewCell {
    var iconImageView: UIImageView?
    // MARK: Properties
    
    /// The Item
    private let item: WhatsNew.Item
    
    /// The Configuration
    private let configuration: WhatsNewViewController.Configuration
    
    // MARK: Initializer
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - item: The WhatsNew Item
    ///   - configuration: The Configuration
    init(item: WhatsNew.Item,
         configuration: WhatsNewViewController.Configuration) {
        // Set item
        self.item = item
        // Set configuration
        self.configuration = configuration
        // Super init default style
        super.init(
            style: .default,
            reuseIdentifier: String(describing: WhatsNewItemTableViewCell.self)
        )
        // Set background color
        self.contentView.backgroundColor = self.configuration.backgroundColor
        // Perform ImageView Configuration
        self.configureImageView()
        // Perform TextLabel Configuration
        self.configureTextLabel()
    }
    
    /// Initializer with Coder always returns nil
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: Private API
    
    /// Configure ImageView
    private func configureImageView() {
        // Check if autoTintImage is activated
        guard let imageView = self.item.imageView else {
            return
        }
        
        self.iconImageView = imageView
        self.imageView?.image = imageWithSize(size: imageView.frame.size)
        self.contentView.addSubview(imageView)
        
        if self.configuration.itemsView.autoTintImage {
            // Set template tinted image
            let templateImage = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.image = templateImage
            imageView.tintColor = self.configuration.tintColor
        } 
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if let frame = self.imageView?.frame {
            iconImageView?.frame = frame
            iconImageView?.tintColor = self.configuration.tintColor
        }
        
    }
    func imageWithSize(size: CGSize, filledWithColor color: UIColor = UIColor.clear,
                       scale: CGFloat = 0.0, opaque: Bool = false) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        color.set()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    /// Configure TextLabel
    private func configureTextLabel() {
        // Set attributed text
        self.textLabel?.attributedText = self.getAttributedTextString()
        // Set font
        self.textLabel?.font = self.configuration.itemsView.subtitleFont
        // Set textcolor
        self.textLabel?.textColor = self.configuration.itemsView.subtitleColor
        // Set number of lines to zero
        self.textLabel?.numberOfLines = 0
        // Set linebreak mode to word wrapping
        self.textLabel?.lineBreakMode = .byWordWrapping
        // Set white background color
        self.backgroundColor = .white
    }
    
    /// Retrieve AttributedString Text String
    ///
    /// - Returns: The Attributed String
    private func getAttributedTextString() -> NSAttributedString {
        // Check if title is empty
        if self.item.title.isEmpty {
            // Just return the item subtitle has no title is available
            return NSAttributedString(string: self.item.subtitle)
        } else {
            // Initialize attributed string
            let attributedString = NSMutableAttributedString(string: "\(self.item.title)\n\(self.item.subtitle)")
            // Add title font
            attributedString.addAttributes(
                [NSAttributedString.Key.font: self.configuration.itemsView.titleFont],
                range: NSRange(location: 0, length: self.item.title.count)
            )
            // Add title color
            attributedString.addAttributes(
                [NSAttributedString.Key.foregroundColor: self.configuration.itemsView.titleColor],
                range: NSRange(location: 0, length: self.item.title.count)
            )
            // Return attributed title and text string
            return attributedString
        }
    }
    
}
