//
// ActivityIndicator.swift
//
// Copyright (c) 2016 Aldrin Clemente
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

open class ActivityIndicator {
    
    fileprivate static var indicatorContainer: UIView!
    fileprivate static var indicator: UIActivityIndicatorView!
    
    open static func show(_ parentView: UIView? = nil) {
        var view: UIView
        if parentView != nil {
            view = parentView!
        } else if let rootView = UIApplication.shared.keyWindow?.subviews.last {
            view = rootView
            
            // Unlike Toast, we're only getting the top-most view when nothing is specified
            // because the user may want to anchor the indicator into an inner view
            while view.superview != nil {
                view = view.superview!
            }
        } else {
            return
        }
        
        if (indicatorContainer == nil) {
            indicatorContainer = UIView()
            indicatorContainer.backgroundColor = UIColor(hex: 0x000000, alpha: 128)
            
            indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicatorContainer.addSubview(indicator)
            indicator.startAnimating()
            
            indicatorContainer.alpha = 0
        }
        
        indicatorContainer.removeFromSuperview()
        indicatorContainer.frame = view.frame
        view.addSubview(indicatorContainer)
        indicatorContainer.bringSubview(toFront: view)
        indicator.center = view.center
        
        indicatorContainer.isHidden = false
        UIView.animate(withDuration: 0.25,
            delay: 0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                indicatorContainer.alpha = 1
            },
            completion: nil)
    }
    
    open static func hide() {
        if indicatorContainer != nil {
            UIView.animate(withDuration: 0.25,
                delay: 0,
                options: UIViewAnimationOptions.allowUserInteraction,
                animations: {
                    indicatorContainer.alpha = 0
                }, completion: { completed in
                    indicatorContainer.isHidden = true
                    indicatorContainer.removeFromSuperview()
                }
            )
        }
    }
}
