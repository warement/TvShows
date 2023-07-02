//
//  BaseNavigation.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

// MARK: Navigation Actions
/// # Action Protocol
///  All navigation actions must conform to this protocol in order to be handled from Actions Handlers.
public protocol Action {}

/// # Base Navigation Actions
///  The folowing actions are commonly used accross all aplication.
///  Thats why they are declared in Presentation Module.
public struct PopAction: Action {
    public init() {}
}

public struct PopToRootViewControllerAction: Action {
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public var animated: Bool = true
}

public struct PopToVCAction: Action {
    public var targetVcType: AnyClass
    public var animated: Bool = true
}

public struct PopWithReloadToVCAction: Action {
    
    public init(targetVcType: AnyClass? = nil, animated: Bool = true) {
        self.targetVcType = targetVcType
        self.animated = animated
    }
    
    public var targetVcType: AnyClass? = nil
    public var animated: Bool = true
    
}

public struct ReloadViewControllerAction: Action {
    
    public init(targetVcType: AnyClass) {
        self.targetVcType = targetVcType
    }
    
    public var targetVcType: AnyClass
    
}

//public struct ShowBottomSheetAction: Action {
//
//    public var data: BottomSheetData
//    public var callback: ((GenericBottomSheetVC) -> Void)? = nil
//    public var closeAction: (() -> Void)? = nil
//
//    public init(
//        data: BottomSheetData,
//        callback: ((GenericBottomSheetVC) -> Void)? = nil,
//        closeAction: (() -> Void)? = nil
//    ) {
//        self.data = data
//        self.callback = callback
//        self.closeAction = closeAction
//    }
//}

//public struct ShowLoaderAction: Action {
//    public init() {}
//}
//
//public struct HideLoaderAction: Action {
//    public init() {}
//}

public struct DismissAction: Action {
    public init() {}
}

/** This protocol must be conformed from Coordinator in order to handle coordinator actions */
public protocol BaseActionHandler: AnyObject {
    func handleBaseAction(action: Action)
    func handleAction(action: Action)
}

/** This protocol must be conformed from ViewModels in order to handle coordinator actions */
public protocol BaseActionDispatcher: AnyObject {
    var actionHandler: BaseActionHandler? { get set }
}

// MARK: - BaseActionHandler Default IML
/**
 Make an extention to `Coordinator` Protocol in order to make all coordinators able to handle **BaseNavActions**
 */
extension Coordinator {
    
    public func handleBaseAction(action: Action) {
        switch action {
        case _ as PopAction:
            navigationController.popViewController(animated: true)
        case let action as PopToRootViewControllerAction:
            navigationController.popToRootViewController(animated: action.animated)
        case let action as PopToVCAction:
            navigationController.viewControllers.forEach({ vc in
                if vc.isKind(of: action.targetVcType) {
                    navigationController.popToViewController(vc, animated: action.animated)
                    return
                }
            })
//        case _ as ShowLoaderAction:
//            GenericLoader.show()
//        case _ as HideLoaderAction:
//            GenericLoader.hide()
        case _ as DismissAction:
            if navigationController.presentedViewController == nil {
                dismiss(animated: true, completion: nil)
            } else {
                navigationController.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        default:
            print("⚠️⚠️⚠️ ----- Unknown Action! ----- ⚠️⚠️⚠️")
        }
    }
}
