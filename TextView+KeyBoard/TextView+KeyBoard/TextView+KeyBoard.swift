//
//  TextView+KeyBoard.swift
//  TextView+KeyBoard
//
//  Created by 成林 on 15/8/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class TextViewKeyBoardVC: UIViewController{
    
    /**  API  */
    var textViewWillBeginEditlosure: ((textView: UITextView)->Void)!
    var textViewDidEndEditClosure: ((textView: UITextView)->Void)!
    var textViewDidChangeClosure: ((textView: UITextView)->Void)!
    
    weak private var pvc: UIViewController!
    weak private var textView: UITextView!
    private var offsetY: CGFloat!
    private var willShow = false
}



extension TextViewKeyBoardVC: UITextViewDelegate{
    
    var ScreenH: CGFloat {return UIScreen.mainScreen().bounds.size.height}
    
    
    /**  直接躲避键盘  */
    func avoid(inVC vc: UIViewController, scrollView: UIScrollView!, textView: UITextView, offsetY: CGFloat, msg: String!){
        
        vc.addChildViewController(self)
        pvc = vc
        self.textView = textView
        self.offsetY = offsetY
        textView.delegate = self
        //安装键盘工具条
        if self.inputAccessoryView == nil {
        
            let av = AccessoryView.instance()
            av.msgLabel.text = msg ?? "请输入您想要输入的内容"
            textView.inputAccessoryView = av

            av.doneBtnActionClosure = {textView.endEditing(true)}
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        if scrollView == nil { //无scrollView的情况
            
            
            
            
            
        }else{
            
        }
        
        
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        willShow = true
        textViewWillBeginEditlosure?(textView: textView)
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        willShow = false
        textViewDidEndEditClosure?(textView: textView)
    }
    
    func textViewDidChange(textView: UITextView) {
        textViewDidChangeClosure?(textView: textView)
    }
    

    func keyboardWillShow(noti: NSNotification){
        
        if !willShow {return}
        
        let info = noti.userInfo as! [String: AnyObject]
        let kbH = info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue().size.height
        let textViewRect = textView.convertRect(textView.bounds, toView: nil)
        let maxH = ScreenH - kbH
        let moveUP = CGRectGetMaxY(textViewRect) - maxH
        
        if moveUP > 0 { //需要上移
            
            UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
                
                /**  别问为什么是7，，经验，，，，  */
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                
                self.pvc.view.transform = CGAffineTransformMakeTranslation(0, -(moveUP+self.offsetY))
                
            })
            
        }
    }
    
    /**  开始编辑  */
    func keyboardDidHide(noti: NSNotification){
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
            
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            
            self.pvc.view.transform = CGAffineTransformIdentity
            
        })
    }
}








