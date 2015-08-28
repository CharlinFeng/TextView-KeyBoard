//
//  ScrollViewVC.swift
//  TextView+KeyBoard
//
//  Created by 冯成林 on 15/8/28.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class ScrollViewVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        TextViewKeyBoardVC().avoid(inVC: self, scrollView: scrollView, textView: textView1, offsetY: 20)
        TextViewKeyBoardVC().avoid(inVC: self, scrollView: scrollView, textView: textView2, offsetY: 40)
        
    }

}
