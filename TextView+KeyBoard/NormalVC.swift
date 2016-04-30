//
//  NormalVC2.swift
//  TextView+KeyBoard
//
//  Created by 成林 on 15/8/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class NormalVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var kb = TextViewKeyBoardVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kb.avoid(inView: self.view, scrollView: nil, textView: textView, offsetY: 10)

        let tkb = TextViewKeyBoardVC()
        tkb.msg = "请输入意见"
        
        /** 开始编辑 */
        tkb.textViewWillBeginEditlosure = {textView in
            
        }
        
        /** 文字改变 */
        tkb.textViewDidChangeClosure = {textView in
            
        }
        
        /** 结束编辑 */
        tkb.textViewDidEndEditClosure = {textView in
        
        }
    

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    

}
