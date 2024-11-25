//
//  iOS DigioApp.swift
//  iOS Digio
//
//  Created by Rodrigo Souza on 07/09/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window else { return false }
        let navigationController = UINavigationController()

        // Usando Coordinating para gerenciar o fluxo
        let rootCoordinator = Coordinating<UINavigationController>.coordinatorHome()

        // Start do coordenador para a primeira tela
        rootCoordinator.navigate(navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Chamado quando o aplicativo está prestes a passar do estado ativo para inativo.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Chamado quando o aplicativo entra em background.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Chamado quando o aplicativo sai do background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Chamado quando o aplicativo se torna ativo novamente.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Chamado quando o aplicativo está prestes a ser encerrado.
    }

}
