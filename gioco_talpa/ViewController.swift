//
//  ViewController.swift
//  gioco_talpa
//
//  Created by Leonardo Basso on 30/03/2019.
//  Copyright © 2019 Leonardo Basso. All rights reserved.
//

import UIKit
var dim_vita: Bool = false // variabile che potrebbe se
var tocco_mancato: Bool = true // potrebbe essere utilizzato per il mancato tocco
var vite: Int = 5 // contatore delle vite
var punteggio: Int = 0 // punteggio che l'utente andrà a conseguire durante il gioco
var serie: Int = 0 // serie di tocchi indicata poi nel viewcontroller del punteggio
var appoggio_serie: Int = 0
var contatore_errori: Int = 0 // per fare un counter degli errori come si deve bisognerebbe aggiungere altre vite con dei caratteri jolly quindi per il momento sarebbe inutilizzabile
var record_attuale: Int = 0 // si potrebbe creare un algoritmo analogo a quello delle serie per poi mettere in evidenza il record nel secondo viewcontroller
var appoggio_record: Int = 0
var velocità: Double = 3.0
let img = UIImageView(image: #imageLiteral(resourceName: "image"))
let img2 = UIImageView(image: #imageLiteral(resourceName: "Image-2"))
let img3 = UIImageView(image: #imageLiteral(resourceName: "Image-3"))
let img_switch_vita = UIImageView(image: #imageLiteral(resourceName: "Image-1"))
class ViewController: UIViewController {
    @IBOutlet weak var view_spazio: UIView!
    @IBOutlet var array_vite: [UIImageView]!
    @IBOutlet weak var btn_termina: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appare() // funzione che serve a far aparire l'immagine
        view_spazio.isUserInteractionEnabled = true
        view.bringSubviewToFront(view_spazio)
        img.tag = 100
        img2.tag = 110
        img.layer.cornerRadius = 2
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowRadius = 10
        img.layer.shadowOpacity = 0.3
        img2.layer.cornerRadius = 2
        img2.layer.shadowColor = UIColor.black.cgColor
        img2.layer.shadowRadius = 10
        img2.layer.shadowOpacity = 0.3
        btn_termina.isEnabled = false
        btn_termina.isHidden = true
        btn_termina.layer.cornerRadius = 3
        btn_termina.layer.shadowColor = UIColor.black.cgColor
        btn_termina.layer.shadowRadius = 10
        btn_termina.layer.shadowOpacity = 0.3
    }
    // potrei fare un aumento di velocità man mano che si va avanti per esempio ogni volta che si perde una vita
    func appare()
    {
        let larghezza_max = Int(view_spazio.frame.width) // prende la larghezza massima della view_spazio
        let altezza_max = Int(view_spazio.frame.height) // prende l'altezza massima della view_spazio
        var altezza_random = Int.random(in: 0...altezza_max - 80) // variabile per il posizionamento immagine
        var larghezza_random = Int.random(in: 0...larghezza_max - 80) // variabile per il posizionamento immagine
        var altezza_random2 = Int.random(in: 0...altezza_max - 80) // variabile per il posizionamento immagine
        var larghezza_random2 = Int.random(in: 0...larghezza_max - 80) // variabile per il posizionamento immagine
        img.frame = CGRect(x: Double(larghezza_random), y: Double(altezza_random), width: 80, height: 80) // vado a definire le caratteristiche dell'immagine del p greco
        img.tag = 100
        img2.frame = CGRect(x: Double(larghezza_random2), y: Double(altezza_random2), width: 80, height: 80) // definizione dell'immagine del segno " - "
        self.view_spazio.addSubview(img) // aggiunta dell'immagine del "p greco"
        self.view_spazio.addSubview(img2) // aggiunta dell'immagine del segno " - "
        let metàLarghezza = CGFloat(img.frame.width/2) // variabile utile al posizionamento all'interno della view_spazio
        let metàAltezza = CGFloat(img.frame.height/2) // variabile utile al posizionamento all'interno della view_spazio
        UIView.animate(withDuration: TimeInterval(velocità), animations: {
            img.center = CGPoint(x: (img.frame.maxX - metàLarghezza) + 0.1, y: (img.frame.maxY - metàAltezza) + 0.1)
            img2.center = CGPoint(x: (img2.frame.maxX - metàLarghezza) + 0.1, y: (img2.frame.maxY - metàAltezza) + 0.1)
        }) { (Bool) in
            if vite > 0
            {
                img.removeFromSuperview()
                self.appare()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let posizione = touch.location(in: view_spazio)
                if img.frame.contains(posizione) // caso in cui si riesce ad intercettare l'immagine del "p-greco"
                {
                    view_spazio.isUserInteractionEnabled = false
                    punteggio+=1
                    serie+=1
                    print(serie) // controllo
                    dim_vita = false
                    img.removeFromSuperview()
                }
                else // caso di errore del tocco
                {
                    view_spazio.isUserInteractionEnabled = false
                    vite -= 1
                    velocità-=0.5
                    if vite == 0 // caso in cui il numero delle vite sia pari a 0
                    {
                        view_spazio.isUserInteractionEnabled = true
                        punteggio-=1
                        if serie > appoggio_serie // dati necessari all'indicazione della serie nel secondo viewController
                        {
                            appoggio_serie = serie
                            serie = 0
                        }
                        else
                        {
                            serie = 0
                        }
                        record_attuale = punteggio
                        if record_attuale > appoggio_record // dati necessari all'indicazione del record nel secondo viewController
                        {
                            appoggio_record = record_attuale
                            record_attuale = 0
                        }
                        else
                        {
                            record_attuale = 0
                        }
                        print("appoggio serie: " + String(appoggio_serie)) // controllo
                        print("serie: " + String(serie)) // controllo
                        print("appoggio record: " + String(appoggio_record)) // controllo
                        print("record: " + String(record_attuale)) // controllo
                        // transizioni che fanno scomparire le due immagini dallo schermo
                        let image1 = UIImage(named: "Image-1")
                        img.image = image1
                        UIView.transition(with: img, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
                        UIView.transition(with: img2, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
                        img.removeFromSuperview()
                        img2.removeFromSuperview()
                        gameover()
                    }
                else // casi in cui le vite siano superiori a 0
                {
                    view_spazio.isUserInteractionEnabled = false
                    punteggio-=1
                    if serie > appoggio_serie // azzeramento della serie in caso di tocco sbagliato
                    {
                        appoggio_serie = serie
                        serie = 0
                    }
                    else
                    {
                        serie = 0
                    }
                    print("appoggio serie: " + String(appoggio_serie)) // controllo
                    print("serie: " + String(serie)) // controllo
                for v in self.array_vite {
                    if v.tag == vite{
                        let image2 = UIImage(named: "Image-1")
                        v.image = image2
                        UIView.transition(with: v, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
                        }
                    }
                    img.removeFromSuperview()
                }
            }
        }
    }
    
    // -------------------- METODI PERSONALIZZATI -------------------- //
    // funzione che fa apparire il bottone per poi passare al viewcontroller dei punteggi
    func gameover() {
        btn_termina.isHidden = false
        UIView.transition(with: btn_termina, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        btn_termina.isEnabled = true
    }
    // funzione che permette di passare al viewcontroller dei punteggi
    @IBAction func unwind(segue: UIStoryboardSegue){
        btn_termina.isHidden = true
        btn_termina.isEnabled = false
        vite = 5
        serie = 0
        appoggio_serie = 0
        punteggio = 0
        contatore_errori = 0
        velocità = 3.0
        for v in self.array_vite{
            v.image = #imageLiteral(resourceName: "cuore_vita")
        }
        img.image = #imageLiteral(resourceName: "image")
        appare()
    }
}
// DispatchQueue.main.asyncAfter(deadline: <#T##DispatchTime#>, execute: <#T##() -> Void#>)
