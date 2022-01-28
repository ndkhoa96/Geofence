//
//  SceneDelegate.swift
//  assignment_geofence
//
//  Created by Khoa Nguyen on 25/01/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: GeotificationsViewController(geofenceAreaUseCase: GeofenceAreaUseCaseImp(repo: UserDefaultGeofenceRepositoryImp())))
        window?.makeKeyAndVisible()
    }


}

