//
//  ScaleSegue.swift
//  gioco_talpa
//
//  Created by Leonardo Basso on 14/04/2019.
//  Copyright © 2019 Leonardo Basso. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {

    override func perform() {
        scale()
    }
        func  scale(){
            let alviewController = self.destination // .destination specifica che quello sarà il controller di destinazione
            let dalViewController = self.source // .source specifica che quello sarà il controller di sorgente
            let containerView = dalViewController.view.superview
            let centro = dalViewController.view.center
            
            alviewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05) // trasforma il viewcontroller tramite una matrice usata nella grafica 2D
            alviewController.view.center = centro // imposta il centro del viewcontroller di destinazione uguale al centro del viewcontroller di sorgente
            containerView?.addSubview(alviewController.view)
            
            // L'animazione vera e propria avviene con il metodo .animate
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                alviewController.view.transform = CGAffineTransform.identity
            } , completion: { success in
                dalViewController.present(alviewController, animated: false, completion: nil) // questa linea di codice permette di presentare visivamente il viewController d'arrivo dal view controller di destinazione
            })
    
    }
}
