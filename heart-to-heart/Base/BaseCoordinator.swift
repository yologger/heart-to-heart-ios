//
//  BaseCoordinator.swift
//  heart-to-heart
//
//  Created by Hyukjung Kwon on 27/08/2020.
//  Copyright © 2020 yologger. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var viewController: UIViewController? { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {

    var viewController: UIViewController?
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
    
    func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }
    
    
}

