![image](https://github.com/nsdictionary/Resource/blob/master/TextView-KeyBoard/logo.jpg)<br />
<br/><br/>


文本域键盘躲避者
===============
<br/>
### 版本信息
.Swift 1.2<br/>
.Xcode 6.3<br/>
.基于MIT开源协议<br/>

#### 请支持我，写满80个框架，从此‘封笔’

<br/>
### 效果图
![image](https://github.com/nsdictionary/Resource/blob/master/TextView-KeyBoard/1.gif)<br />

<br/>
### OC版本
之前写过OC版本的[TextField组键盘躲避者](https://github.com/nsdictionary/CoreTFManagerVC)
<br/>

<br/><br/><br/>
一句代码集成
===============
<br/>
####您的UITextView 无需继承任何基类！一句代码即可集成：<br/>
TextViewKeyBoardVC().avoid(inVC: self, scrollView: nil, textView: textView, offsetY: 10)

###细节说明：<br/>
1. scrollView已经处理，请根据您的情况传入。<br/>
2. offsetY是框架的特色，有的时候您的UITextView下方可能有提示文字或者事件按钮，你可以预留更多的空间。<br/>
3. 键盘工具条已经封装，想要修改上面的文字如下：

        let tkb = TextViewKeyBoardVC()
        tkb.msg = "请输入意见"
<br/>
4. 框架基于通知和代理，生命周期已经管理，你无需担心取消通知监听。<br/>
5. 框架设置了textView的代理，请不要自行再设置代理，需要代理？放心，closure已经考虑了这个问题：

        /** 开始编辑 */
        tkb.textViewWillBeginEditlosure = {textView in
            
        }
        
        /** 文字改变 */
        tkb.textViewDidChangeClosure = {textView in
            
        }
        
        /** 结束编辑 */
        tkb.textViewDidEndEditClosure = {textView in
        
        }

