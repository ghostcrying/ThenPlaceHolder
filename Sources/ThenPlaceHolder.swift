//
//  UIScrollView+Extension.swift
//  ThenPlaceHolder
//
//  Created by ghost on 2023/1/6.
//

import UIKit
import Foundation

private var KTThenPlaceHolderDataSource  = "com.then.placeholder.datasource"
private var KTThenPlaceHolderDelegate    = "com.then.placeholder.delegate"
private var KTThenPlaceHolderView        = "com.then.placeholder.view"
private var KTThenPlaceHolderConfigure   = "com.then.placeholder.configure"

extension UIScrollView: UIGestureRecognizerDelegate {
    
    //MARK: - privateProperty
    private
    var configureThenPlaceHolderView: ((ThenPlaceHolderView) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &KTThenPlaceHolderConfigure) as? (ThenPlaceHolderView) -> Void
        }
        set {
            objc_setAssociatedObject(self, &KTThenPlaceHolderConfigure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            UIScrollView.swizzleReloadData
            if self is UITableView {
                UIScrollView.swizzleEndUpdates
            }
        }
    }
    
    private
    var placeholderView: ThenPlaceHolderView? {
        get {
            if let view = objc_getAssociatedObject(self, &KTThenPlaceHolderView) as? ThenPlaceHolderView {
                return view
            } else {
                let view = ThenPlaceHolderView.init(frame: frame)
                view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                view.isHidden = true
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapContentView(_:)))
                tapGesture.delegate = self
                view.addGestureRecognizer(tapGesture)
                view.button.addTarget(self, action: #selector(didTapDataButton(_:)), for: .touchUpInside)

                objc_setAssociatedObject(self, &KTThenPlaceHolderView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return view
            }
        }
        set {
            objc_setAssociatedObject(self, &KTThenPlaceHolderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    internal var itemsCount: Int {
        var items = 0
        
        // UITableView support
        if let tableView = self as? UITableView {
            var sections = 1
            
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            var sections = 1
            
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        
        return items
    }
    
    //MARK: - Data Source Getters
    private
    var titleLabelString: NSAttributedString? {
        return placeDataSource?.title(self)
    }
    
    private
    var detailLabelString: NSAttributedString? {
        return placeDataSource?.description(self)
    }
    
    private
    var image: UIImage? {
        return placeDataSource?.image(self)
    }
    
    private
    var imageAnimation: CAAnimation? {
        return placeDataSource?.imageAnimation(self)
    }
    
    private
    var imageTintColor: UIColor? {
        return placeDataSource?.imageTintColor(self)
    }
    
    private
    func buttonTitle(for state: UIControl.State) -> NSAttributedString? {
        return placeDataSource?.buttonTitle(self, for: state)
    }
    
    private
    func buttonImage(for state: UIControl.State) -> UIImage? {
        return placeDataSource?.buttonImage(self, for: state)
    }
    
    private
    func buttonBackgroundImage(for state: UIControl.State) -> UIImage? {
        return placeDataSource?.buttonBackgroundImage(self, for: state)
    }
    
    private
    var dataSetBackgroundColor: UIColor? {
        return placeDataSource?.backgroundColor(self)
    }
    
    private
    var customView: UIView? {
        return placeDataSource?.customView(self)
    }
    
    private
    var verticalOffset: CGFloat {
        return placeDataSource?.verticalOffset(self) ?? 0.0
    }
    
    private
    var verticalSpace: CGFloat {
        return placeDataSource?.spaceHeight(self) ?? 0.0
    }
    
    //MARK: - Delegate Getters & Events (Private)
    
    private
    var shouldFadeIn: Bool {
        return placeDelegate?.placeHolderShouldFadeIn(self) ?? true
    }
    
    private
    var shouldDisplay: Bool {
        return placeDelegate?.placeHolderShouldDisplay(self) ?? true
    }
    
    private
    var shouldBeForcedToDisplay: Bool {
        return placeDelegate?.placeHolderShouldBeForcedToDisplay(self) ?? false
    }
    
    private
    var isTouchAllowed: Bool {
        return placeDelegate?.placeHolderShouldAllowTouch(self) ?? true
    }
    
    private
    var isScrollAllowed: Bool {
        return placeDelegate?.placeHolderShouldAllowScroll(self) ?? false
    }
    
    private
    var isImageViewAnimateAllowed: Bool {
        return placeDelegate?.placeHolderShouldAnimateImageView(self) ?? true
    }
    
    private
    func willAppear() {
        placeDelegate?.placeHolderWillAppear(self)
        placeholderView?.willAppearHandle?()
    }
    
    private func didAppear() {
        placeDelegate?.placeHolderDidAppear(self)
        placeholderView?.didAppearHandle?()
    }
    
    private
    func willDisappear() {
        placeDelegate?.placeHolderWillDisappear(self)
        placeholderView?.willDisappearHandle?()
    }
    
    private
    func didDisappear() {
        placeDelegate?.placeHolderDidDisappear(self)
        placeholderView?.didDisappearHandle?()
    }
    
    @objc private
    func didTapContentView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        placeDelegate?.placeHolder(self, didTapView: view)
        placeholderView?.didTapContentViewHandle?()
    }
    
    @objc private
    func didTapDataButton(_ sender: UIButton) {
        placeDelegate?.placeHolder(self, didTapButton: sender)
        placeholderView?.didTapDataButtonHandle?()
    }
        
    private
    func invalidate() {
        willDisappear()
        if let view = placeholderView {
            view.prepareForReuse()
            view.isHidden = true
            // view.removeFromSuperview()
            // placeholderView = nil
        }
        self.isScrollEnabled = true
        didDisappear()
    }
        
}

//MARK: - public
extension UIScrollView {
    
    public var placeDataSource: ThenPlaceHolderDataSource? {
        get {
            let container = objc_getAssociatedObject(self, &KTThenPlaceHolderDataSource) as? WeakObjectContainer
            return container?.weakObject as? ThenPlaceHolderDataSource
        }
        set {
            if newValue == nil {
                self.invalidate()
            }

            objc_setAssociatedObject(self, &KTThenPlaceHolderDataSource, WeakObjectContainer(with: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            UIScrollView.swizzleReloadData
            if self is UITableView {
                UIScrollView.swizzleEndUpdates
            }
        }
    }
    
    public var placeDelegate: ThenPlaceHolderDelegate? {
        get {
            let container = objc_getAssociatedObject(self, &KTThenPlaceHolderDelegate) as? WeakObjectContainer
            return container?.weakObject as? ThenPlaceHolderDelegate
        }
        set {
            if newValue == nil {
                self.invalidate()
            }
            objc_setAssociatedObject(self, &KTThenPlaceHolderDelegate, WeakObjectContainer(with: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isVisible: Bool {
        if let view = objc_getAssociatedObject(self, &KTThenPlaceHolderView) as? ThenPlaceHolderView {
            return !view.isHidden
        }
        return false
    }
    
    public func placeHolderView(_ closure: @escaping (ThenPlaceHolderView) -> Void) {
        configureThenPlaceHolderView = closure
    }
    
    public func reloadPlaceHolder() {
        guard (placeDataSource != nil || configureThenPlaceHolderView != nil) else {
            return
        }
        
        if (shouldDisplay && itemsCount == 0) || shouldBeForcedToDisplay {
            // Notifies that the placeholder view will appear
            willAppear()
            
            if let view = placeholderView {
                
                // Configure placeholder fade in display
                view.fadeInOnDisplay = shouldFadeIn
                
                if view.superview == nil {
                    // Send the view all the way to the back, in case a header and/or footer is present, as well as for sectionHeaders or any other content
                    if (self is UITableView) || (self is UICollectionView) || (subviews.count > 1) {
                        insertSubview(view, at: 0)
                    } else {
                        addSubview(view)
                    }
                }
                
                // Removing view resetting the view and its constraints it very important to guarantee a good state
                // If a non-nil custom view is available, let's configure it instead
                view.prepareForReuse()
                
                if let customView = self.customView {
                    view.customView = customView
                } else {
                    // Get the data from the data source
                    
                    let renderingMode: UIImage.RenderingMode = imageTintColor != nil ? .alwaysTemplate : .alwaysOriginal
                    
                    view.verticalSpace = verticalSpace
                    
                    // Configure Image
                    if let image = image {
                        view.imageView.image = image.withRenderingMode(renderingMode)
                        if let imageTintColor = imageTintColor {
                            view.imageView.tintColor = imageTintColor
                        }
                    }
                    
                    // Configure title label
                    if let titleLabelString = titleLabelString {
                        view.titleLabel.attributedText = titleLabelString
                    }
                    
                    // Configure detail label
                    if let detailLabelString = detailLabelString {
                        view.detailLabel.attributedText = detailLabelString
                    }
                    
                    // Configure button
                    if let buttonImage = buttonImage(for: .normal) {
                        view.button.setImage(buttonImage, for: .normal)
                        view.button.setImage(self.buttonImage(for: .highlighted), for: .highlighted)
                    } else if let buttonTitle = buttonTitle(for: .normal) {
                        view.button.setAttributedTitle(buttonTitle, for: .normal)
                        view.button.setAttributedTitle(self.buttonTitle(for: .highlighted), for: .highlighted)
                        view.button.setBackgroundImage(self.buttonBackgroundImage(for: .normal), for: .normal)
                        view.button.setBackgroundImage(self.buttonBackgroundImage(for: .highlighted), for: .highlighted)
                    }
                }
                
                // Configure offset
                view.verticalOffset = verticalOffset
                
                // Configure the placeholder view
                view.backgroundColor = dataSetBackgroundColor
                view.isHidden = false
                view.clipsToBounds = true
                
                // Configure placeholder userInteraction permission
                view.isUserInteractionEnabled = isTouchAllowed
                
                // Configure scroll permission
                self.isScrollEnabled = isScrollAllowed
                
                // Configure image view animation
                if self.isImageViewAnimateAllowed {
                    if let animation = imageAnimation {
                        view.imageView.layer.add(animation, forKey: nil)
                    }
                } else {
                    view.imageView.layer.removeAllAnimations()
                }
                
                if let config = configureThenPlaceHolderView {
                    config(view)
                }
                
                view.setupConstraints()
                view.layoutIfNeeded()
            }
            
            // Notifies that the placeholder view did appear
            didAppear()
        } else if isVisible {
            invalidate()
        }
    }
}

//MARK: - reload
extension UIScrollView {
    
    @objc private func tableViewSwizzledReloadData() {
        tableViewSwizzledReloadData()
        reloadPlaceHolder()
    }
    
    @objc private func tableViewSwizzledEndUpdates() {
        tableViewSwizzledEndUpdates()
        reloadPlaceHolder()
    }
    
    @objc private func collectionViewSwizzledReloadData() {
        collectionViewSwizzledReloadData()
        reloadPlaceHolder()
    }
}

//MARK: - swizzling
extension UIScrollView {
    
    private class func swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(aClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)
        
        let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    private static let swizzleReloadData: () = {
        let tableViewOriginalSelector = #selector(UITableView.reloadData)
        let tableViewSwizzledSelector = #selector(UIScrollView.tableViewSwizzledReloadData)
        
        swizzleMethod(for: UITableView.self, originalSelector: tableViewOriginalSelector, swizzledSelector: tableViewSwizzledSelector)
        
        let collectionViewOriginalSelector = #selector(UICollectionView.reloadData)
        let collectionViewSwizzledSelector = #selector(UIScrollView.collectionViewSwizzledReloadData)
        
        swizzleMethod(for: UICollectionView.self, originalSelector: collectionViewOriginalSelector, swizzledSelector: collectionViewSwizzledSelector)
    }()
    
    private static let swizzleEndUpdates: () = {
        let originalSelector = #selector(UITableView.endUpdates)
        let swizzledSelector = #selector(UIScrollView.tableViewSwizzledEndUpdates)
        
        swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()

}
