//
//  IEHTextView.swift
//  IEHTextView
//
//  Created by Ismail El-habbash on 6/12/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import UIKit

@IBDesignable class IEHTextView: UITextView {
    @IBInspectable var pText:String = "Empty placeholder" {
        didSet {
            placeholderLabel.text = pText
        }
    }
    
    @IBInspectable var pColor:UIColor = UIColor.grayColor() {
        didSet {
            placeholderLabel.textColor = pColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLabelWithText(pText)
        registerToNotifications()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureLabelWithText(pText)
        registerToNotifications()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func registerToNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(IEHTextView.textDidChange), name: UITextViewTextDidChangeNotification, object: self)
    }
    
    func textDidChange() {
        if self.text.characters.count > 0 {
            placeholderLabel.hidden = true
        } else {
            placeholderLabel.hidden = false
        }
        
    }
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(12.0)
        label.textColor = UIColor.grayColor()
        return label
    }()
    
    private func configureLabelWithText(text:String) {
        configureLabel()
        placeholderLabel.text = text
    }
    private func configureLabel() {
        self.addSubview(placeholderLabel)
        
        let view = ["placeholderLabel":placeholderLabel]
        let horizonalConstraint  = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[placeholderLabel]-0-|", options: [], metrics: nil, views: view)
        let VerticalConstraint  = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[placeholderLabel]->=0-|", options: [], metrics: nil, views: view)
        NSLayoutConstraint.activateConstraints(horizonalConstraint + VerticalConstraint)
    }
}
