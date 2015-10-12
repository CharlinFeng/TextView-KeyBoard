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
    var msg: String!{didSet{av.msgLabel.text=msg}}
    
    weak private var pvc: UIViewController!
    weak private var textView: UITextView!
    lazy private var av = {AccessoryView.instance()}()
    private var offsetY: CGFloat!
    private var willShow = false
    private var scrollView: UIScrollView!
    
    deinit{NSNotificationCenter.defaultCenter().removeObserver(self)}
}


extension TextViewKeyBoardVC: UITextViewDelegate{
    
    var ScreenH: CGFloat {return UIScreen.mainScreen().bounds.size.height}
    
    /**  直接躲避键盘  */
    func avoid(inVC vc: UIViewController, scrollView: UIScrollView!, textView: UITextView, offsetY: CGFloat){
        
        if !textView .isDescendantOfView(vc.view) {return}
        vc.addChildViewController(self)
        pvc = vc
        self.textView = textView
        self.offsetY = offsetY
        self.scrollView = scrollView
        textView.delegate = self
        if self.inputAccessoryView == nil {textView.inputAccessoryView = av;av.doneBtnActionClosure = {textView.endEditing(true)}}
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardWillHideNotification, object: nil)
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
        let kbH = info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size.height
        let textViewRect = textView.convertRect(textView.bounds, toView: nil)
        let maxH = ScreenH - kbH
        let moveUP = CGRectGetMaxY(textViewRect) - maxH
        
        var transfromH: CGFloat = 0
        var scrollEatContenth: CGFloat = 0
        
        if scrollView == nil {transfromH = -(moveUP+self.offsetY)}
        else {
            let scrollableH = scrollView.contentSize.height - scrollView.bounds.size.height
            let maxOffsetY = scrollableH
            let needOffsetY = moveUP + scrollView.contentOffset.y
            if needOffsetY <= maxOffsetY {scrollEatContenth = needOffsetY + self.offsetY}
            else{let extraH = needOffsetY - maxOffsetY;scrollEatContenth = maxOffsetY;transfromH =  -(extraH + self.offsetY)}
        }
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
            /**  别问为什么是7，，经验，，，，  */
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            if self.scrollView != nil {self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, scrollEatContenth)}
            self.pvc.view.transform = CGAffineTransformMakeTranslation(0, transfromH)
        })
    }
    
    /**  开始编辑  */
    func keyboardDidHide(noti: NSNotification){
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
            
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            
            self.pvc.view.transform = CGAffineTransformIdentity
            
        })
    }
}
