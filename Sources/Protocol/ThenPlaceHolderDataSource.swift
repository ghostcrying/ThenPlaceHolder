//
//  ThenPlaceHolderDataSource.swift
//  ThenPlaceHolder
//
//  Created by ghost on 2023/1/6.
//

import UIKit
import Foundation

/// The object that acts as the data source of the placeholder view.
public protocol ThenPlaceHolderDataSource {
    
    /// Asks the data source for the title of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    ///
    /// - Parameter scrollView: scrollView A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset title, combining font, text color, text pararaph style, etc.
    func title(_ scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for the description of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    ///
    /// - Parameter scrollView: scrollView A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset description text, combining font, text color, text pararaph style, etc.
    func description(_ scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for the image of the dataset.
    ///
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An image for the dataset.
    func image(_ scrollView: UIScrollView) -> UIImage?
    
    /// Asks the data source for a tint color of the image dataset. Default is nil.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the data source.
    /// - Returns: A color to tint the image of the dataset.
    func imageTintColor(_ scrollView: UIScrollView) -> UIColor?

    /// Asks the data source for the image animation of the dataset.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: image animation
    func imageAnimation(_ scrollView: UIScrollView) -> CAAnimation?
    
    /// Asks the data source for the title to be used for the specified button state.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    ///
    /// - Parameters:
    ///   - scrollView: A scrollView subclass object informing the data source.
    ///   - forState: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func buttonTitle(_ scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString?
    
    /// Asks the data source for the image to be used for the specified button state.
    /// This method will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
    ///
    /// - Parameters:
    ///   - scrollView: A scrollView subclass object informing the data source.
    ///   - forState: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An image for the dataset button imageview.
    func buttonImage(_ scrollView: UIScrollView, for state: UIControl.State) -> UIImage?
    
    /// Asks the data source for a background image to be used for the specified button state.
    /// There is no default style for this call.
    ///
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - forState: The state that uses the specified image. The values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func buttonBackgroundImage(_ scrollView: UIScrollView, for state: UIControl.State) -> UIImage?

    /// Asks the data source for the background color of the dataset. Default is clear color.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the data source.
    /// - Returns: A color to be applied to the dataset background view.
    func backgroundColor(_ scrollView: UIScrollView) -> UIColor?

    /// Asks the data source for a custom view to be displayed instead of the default views such as labels, imageview and button. Default is nil.
    /// Use this method to show an activity view indicator for loading feedback, or for complete custom placeholder source.
    /// Returning a custom view will ignore -offsetForEmptyDataSet and -spaceHeightForEmptyDataSet configurations.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: The custom view.
    func customView(_ scrollView: UIScrollView) -> UIView?

    /// Asks the data source for a offset for vertical alignment of the content. Default is 0.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: The offset for vertical alignment.
    func verticalOffset(_ scrollView: UIScrollView) -> CGFloat

    /// Asks the data source for a vertical space between elements. Default is 11 pts.
    ///
    /// - Parameter scrollView: A scrollView subclass object informing the delegate.
    /// - Returns: The space height between elements.
    func spaceHeight(_ scrollView: UIScrollView) -> CGFloat

}

public extension ThenPlaceHolderDataSource {
    
    func title(_ scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
    
    func description(_ scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
    
    func image(_ scrollView: UIScrollView) -> UIImage? {
        return nil
    }
    
    func imageTintColor(_ scrollView: UIScrollView) -> UIColor? {
        return nil
    }
    
    func imageAnimation(_ scrollView: UIScrollView) -> CAAnimation? {
        return nil
    }
 
    func buttonTitle(_ scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return nil
    }
    
    func buttonImage(_ scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return nil
    }

    func buttonBackgroundImage(_ scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return nil
    }
    
    func backgroundColor(_ scrollView: UIScrollView) -> UIColor? {
        return nil
    }
    
    func customView(_ scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func verticalOffset(_ scrollView: UIScrollView) -> CGFloat {
        return 0
    }
 
    func spaceHeight(_ scrollView: UIScrollView) -> CGFloat {
        return 11
    }
}
