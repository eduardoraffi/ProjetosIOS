//
//  TestView.swift
//  xibTeste
//
//  Created by Hst Dev on 20/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class TestView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var campoDigita: UITextField!
    @IBOutlet weak var titulo: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TestView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
