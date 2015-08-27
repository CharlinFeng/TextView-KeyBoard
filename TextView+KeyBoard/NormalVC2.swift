//
//  NormalVC2.swift
//  TextView+KeyBoard
//
//  Created by 成林 on 15/8/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class NormalVC2: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextViewKeyBoardVC().avoid(inVC: self, scrollView: nil, textView: textView, offsetY: 10, msg: nil)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    

}
