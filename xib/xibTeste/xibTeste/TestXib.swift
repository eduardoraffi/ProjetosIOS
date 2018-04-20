//
//  TestXib.swift
//  xibTeste
//
//  Created by Hst Dev on 20/04/2018.
//  Copyright © 2018 Hst Dev. All rights reserved.
//

import UIKit

class TestXib: UIView {

    @IBOutlet weak var viewXbi: UIView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    	commonInit()
    }
    private func commonInit()
    {
        Bundle.main.loadNibNamed("TestXib", owner: self, options: nil)
        addSubview(viewXbi)
        viewXbi.frame = self.bounds
        viewXbi.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
