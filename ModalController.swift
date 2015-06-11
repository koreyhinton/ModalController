//
//  ModalController.swift
//  ModalTest
//
//  Created by Korey Hinton on 6/11/15.
//  Copyright © 2015 Korey Hinton. All rights reserved.
//

import Foundation
import UIKit


private let ModalDefaultPresentationStyle: UIModalPresentationStyle = .OverCurrentContext
private let ModalDefaultContentCornerRadius: CGFloat = 15.0
private let ModalDefaultBackgroundDarkness: CGFloat = 0.7
private let ModalDefaultTapBGToClose = true
private let ModalDefaultTapContentToClose = false
private let ModalCloseSelector: Selector = "dismiss"

class ModalController: UIViewController {
    
    // configurables
    var backgroundDarkness = ModalDefaultBackgroundDarkness
    var closeOnContentTap = ModalDefaultTapContentToClose
    var closeOnBGTap = ModalDefaultTapBGToClose
    
    // This must be set either programmatically or as an outlet
    @IBOutlet var content: UIView!
    
    func contentMake(wid width: Double, hgt height: Double, bgColor backgroundColor: UIColor, cornerRad cornerRadius: CGFloat? = nil) {
        let contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
        contentView.backgroundColor = backgroundColor
        if cornerRadius != nil {
            contentView.layer.cornerRadius = cornerRadius!
        }
        self.content = contentView
    }
    
    var onViewDidLayoutSubviews: ((modalBGView:UIView,contentView:UIView)->Void)?
    var onClose: (()->Void)?
    var onCloseCompletion: (()->Void)?
    
    // Programmatic Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = ModalDefaultPresentationStyle
    }
    // Storyboard Initialization
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = ModalDefaultPresentationStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        
        view.userInteractionEnabled = true
        content.userInteractionEnabled = true
        
        if closeOnBGTap == true {
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: ModalCloseSelector))
        }
        
        if closeOnContentTap == true {
            content!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: ModalCloseSelector))
        } else {
            content!.addGestureRecognizer(UITapGestureRecognizer(target: nil, action: nil))
        }
        
        view.addSubview(content)
        
        // make all superviews clear
        if let firstSuperView = view.superview {
            firstSuperView.backgroundColor = UIColor.clearColor()
            var current = firstSuperView.superview
            while current != nil {
                current!.backgroundColor = UIColor.clearColor()
                current = current?.superview
            }
        }
    }
    
    func dismiss() {
        onClose?()
        dismissViewControllerAnimated(true) { () -> Void in
            onCloseCompletion?()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(backgroundDarkness)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        content!.center = view.center
        onViewDidLayoutSubviews?(modalBGView:view, contentView:content) // custom positioning
    }
    
}
