//
//  PageViewController.swift
//  Landmarks
//
//  Created by Brian Zhang on 2020-12-26.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    // SwiftUI calls this makeCoordinator() method before makeUIViewController(context:), so that you have access to the coordinator object when configuring your view controller.
    // You can use this coordinator to implement common Cocoa patterns, such as delegates, data sources, and responding to user events via target-action.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // SwiftUI calls this method a single time when it’s ready to display the view, and then manages the view controller’s life cycle.
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    // SwiftUI manages your UIViewControllerRepresentable type’s coordinator, and provides it as part of the context when calling the methods you created above.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map{UIHostingController(rootView: $0)} // the system initializes them only once, and before you need them to update the view controller.
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {return nil}
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.lastIndex(of: viewController) else {return nil}
            if index == controllers.count - 1 {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
            let visibleViewController = pageViewController.viewControllers?.first,
            let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
