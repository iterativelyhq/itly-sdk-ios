//
//  AppDelegate.swift
//  SampleApp_Carthage
//
//  Copyright © 2020 Iteratively. All rights reserved.
//

import UIKit
import ItlySdk
import ItlyIterativelyPlugin
import ItlySchemaValidatorPlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let iterativelyOptions = IterativelyOptions(
            batchSize: 1,
            flushQueueSize: 1,
            disabled: false)

        let iterativelyPlugin = try! IterativelyPlugin("api-key",
                                                       url: "http://localhost:8080/test",
                                                       options: iterativelyOptions)


        let validatorPlugin = ItlySchemaValidatorPlugin()

        Itly.shared.load(Context(requiredString: "Required string"),
                         options: Options(//environment: .production,
                                          disabled: false,
                                          plugins: [iterativelyPlugin, validatorPlugin],
                                          validation: ValidationOptions(trackInvalid: true,
                                                                        errorOnInvalid: false),
                                          logger: ConsoleLogger()))

        let userId = "userId"
        Itly.shared.identify(userId, properties: Identify(requiredNumber: 42.0))
        Itly.shared.group("groupId", properties: Group(requiredBoolean: true))
        Itly.shared.track(EventNoProperties())

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
