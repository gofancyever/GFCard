//
//  NotificationHandler.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

enum UserNotificationType: String {
    case timeInterval
    case timeIntervalForeground
    case pendingRemoval
    case pendingUpdate
    case deliveredRemoval
    case deliveredUpdate
    case actionable
    case mutableContent
    case media
    case customUI
}

extension UserNotificationType {
    var descriptionText: String {
        switch self {
        case .timeInterval: return "You need to switch to background to see the notification."
        case .timeIntervalForeground: return "The notification will show in-app. See NotificationHandler for more."
        default: return rawValue
        }
    }
    
    var title: String {
        switch self {
        case .timeInterval: return "Time"
        case .timeIntervalForeground: return "Foreground"
        default: return rawValue
        }
    }
}



enum UserNotificationCategoryType: String {
    case saySomething
    case card
}

enum SaySomethingCategoryAction: String {
    case input
    case goodbye
    case none
}

enum CustomizeUICategoryAction: String {
    case `switch`
    case open
    case dismiss
}

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let notificationType = UserNotificationType(rawValue: notification.request.identifier) else {
            completionHandler([])
            return
        }

        let options: UNNotificationPresentationOptions
        
        switch notificationType {
        case .timeIntervalForeground:
            options = [.alert, .sound]
        case .pendingRemoval:
            options = [.alert, .sound]
        case .pendingUpdate:
            options = [.alert, .sound]
        case .deliveredRemoval:
            options = [.alert, .sound]
        case .deliveredUpdate:
            options = [.alert, .sound]
        case .actionable:
            options = [.alert, .sound]
        case .media:
            options = [.alert, .sound]
        default:
            options = [.alert, .sound]
        }
        completionHandler(options)
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let category = UserNotificationCategoryType(rawValue: response.notification.request.content.categoryIdentifier) {
            switch category {
            case .saySomething:
                handleSaySomthing(response: response)
            case .card:
                handleCardUI(response: response)
            }
        }
        completionHandler()
    }
    
    private func handleSaySomthing(response: UNNotificationResponse) {
        let text: String
        
        if let actionType = SaySomethingCategoryAction(rawValue: response.actionIdentifier) {
            switch actionType {
            case .input: text = (response as! UNTextInputNotificationResponse).userText
            case .goodbye: text = "Goodbye"
            case .none: text = ""
            }
        } else {
            // Only tap or clear. (You will not receive this callback when user clear your notification unless you set .customDismissAction as the option of category)
            text = ""
        }
        
        if !text.isEmpty {
            print(text)
        }
    }
    
    private func handleCardUI(response: UNNotificationResponse) {
        print(response.actionIdentifier)
    }
    
    func sendCardNoti(title:String,body:String?) {
        
        let path = Bundle.main.path(forResource: "onevcat", ofType:"jpg")!
        let url = URL(fileURLWithPath:path)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body ?? ""
        
        guard let att = try? UNNotificationAttachment(identifier: "card-\(title)", url: url, options: [UNNotificationAttachmentOptionsThumbnailHiddenKey:true])  else {
            return
        }
        
        content.attachments = [att]
        content.userInfo = ["items": [["title": "Photo 1", "text": "Cute girl"], ["title": "Photo 2", "text": "Cute cat"]]]

        // Set category to use customized UI
        content.categoryIdentifier = "customUI"
        //            UserNotificationCategoryType.card.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = UserNotificationType.customUI.rawValue
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Customized UI Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    /// 注册通知类型
    func registerNotiCategory() {
        let customUICategory: UNNotificationCategory = {
            let nextAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.switch.rawValue,
                title: "提示",
                options: [])
            let openAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.open.rawValue,
                title: "查看",
                options: [.foreground])
            let dismissAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.dismiss.rawValue,
                title: "知道",
                options: [.destructive])
            return UNNotificationCategory(identifier:"customUI", actions: [nextAction, openAction, dismissAction], intentIdentifiers: [], options: [])
        }()
        UNUserNotificationCenter.current().setNotificationCategories([customUICategory])
    }
    
    /// 请求通知权限/判断通知权限是否开启
    ///
    /// - Parameter completionHandler: 结果
    func setupNoti(completionHandler: ((Bool) -> Void)?) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("通知权限被拒绝")
            print(granted)
            print(error)
            completionHandler?(granted)
            
        }
    }
}

