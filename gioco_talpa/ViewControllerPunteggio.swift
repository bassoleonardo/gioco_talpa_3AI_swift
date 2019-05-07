//
//  ViewControllerPunteggio.swift
//  gioco_talpa
//
//  Created by Leonardo Basso on 14/04/2019.
//  Copyright © 2019 Leonardo Basso. All rights reserved.
//

import UIKit


class ViewControllerPunteggio: UIViewController {

    @IBOutlet weak var btn_riavvia: UIButton!
    @IBOutlet weak var lbl_punteggio: UILabel!
    @IBOutlet weak var lbl_serie: UILabel!
    @IBOutlet weak var lbl_record: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_punteggio.text = "PUNTEGGIO:    " + String(punteggio)
        lbl_serie.text = "SERIE: " + String(appoggio_serie)
        lbl_record.text = "RECORD: " + String(appoggio_record)
        btn_riavvia.layer.cornerRadius = 3
        btn_riavvia.layer.shadowColor = UIColor.black.cgColor
        btn_riavvia.layer.shadowRadius = 10
        btn_riavvia.layer.shadowOpacity = 0.3
    }
}
