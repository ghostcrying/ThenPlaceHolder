//
//  ThenPlaceHolderDelegate.swift
//  ThenPlaceHolder
//
//  Created by ghost on 2023/1/6.
//

import UIKit
import Foundation

/// The object that acts as the delegate of the placeholder.
///
/// @discussion All delegate methods are optional. Use this delegate for receiving action callbacks.
public protocol ThenPlaceHolderDelegate {
    
    /// Asks the delegate to know if the placeholder should fade in when displayed. Default is true.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: true if the placeholder should fade in.
    func placeHolderShouldFadeIn(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate to know if the placeholder should still be displayed when the amount of items is more than 0. Default is false.
    ///
    /// - Parameter scrollView:  A scrollView subclass object informing the delegate.
    /// - Returns: true if placeholder should be forced to display
    func placeHolderShouldBeForcedToDisplay(_ scrollView: UIScrollView) -> Bool

    /// Asks the delegate to know if the placeholder should be rendered and displayed. Default is true.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: true if the placeholder should show.
    func placeHolderShouldDisplay(_ scrollView: UIScrollView) -> Bool

    /// Asks the delegate for touch permission. Default is true.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: true if the placeholder receives touch gestures.
    func placeHolderShouldAllowTouch(_ scrollView: UIScrollView) -> Bool

    /// Asks the delegate for scroll permission. Default is false.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: true if the placeholder is allowed to be scrollable.
    func placeHolderShouldAllowScroll(_ scrollView: UIScrollView) -> Bool

    /// Asks the delegate for image view animation permission. Default is false.
    /// Make sure to return a valid CAAnimation object from imageAnimationForThenPlaceHolder:
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: true if the placeholder is allowed to animate
    func placeHolderShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool

    /// Tells the delegate that the placeholder view was tapped.
    /// Use this method either to resignFirstResponder of a textfield or searchBar.
    ///
    /// - Parameters:
    ///   - scrollView: scrollView A scrollView subclass informing the delegate.
    ///   - view: the view tapped by the user
    func placeHolder(_ scrollView: UIScrollView, didTapView view: UIView)

    /// Tells the delegate that the action button was tapped.
    ///
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the delegate.
    ///   - button: the button tapped by the user
    func placeHolder(_ scrollView: UIScrollView, didTapButton button: UIButton)

    /// Tells the delegate that the empty data set will appear.
    ///
    /// - Parameter scrollView: A scrollView subclass informing the delegate.
    func placeHolderWillAppear(_ scrollView: UIScrollView)

    /// Tells the delegate that the empty data set did appear.
    ///
    /// - Parameter scrollView: A scrollView subclass informing the delegate.
    func placeHolderDidAppear(_ scrollView: UIScrollView)

    /// Tells the delegate that the empty data set will disappear.
    ///
    /// - Parameter scrollView: A scrollView subclass informing the delegate.
    func placeHolderWillDisappear(_ scrollView: UIScrollView)

    /// Tells the delegate that the empty data set did disappear.
    ///
    /// - Parameter scrollView: A scrollView subclass informing the delegate.
    func placeHolderDidDisappear(_ scrollView: UIScrollView)

}

public extension ThenPlaceHolderDelegate {
    
    func placeHolderShouldFadeIn(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func placeHolderShouldBeForcedToDisplay(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    func placeHolderShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func placeHolderShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func placeHolderShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func placeHolderShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func placeHolder(_ scrollView: UIScrollView, didTapView view: UIView) { }
    
    func placeHolder(_ scrollView: UIScrollView, didTapButton button: UIButton) { }
    
    func placeHolderWillAppear(_ scrollView: UIScrollView) { }
    
    func placeHolderDidAppear(_ scrollView: UIScrollView) { }
    
    func placeHolderWillDisappear(_ scrollView: UIScrollView) { }
    
    func placeHolderDidDisappear(_ scrollView: UIScrollView) { }
    
}
