//
//  RoundButton.swift
//  IphoneCal
//
//  Created by Junseok Lee on 2021/09/07.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable
    var isRound:Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height/2
            }
        }
    }

}
