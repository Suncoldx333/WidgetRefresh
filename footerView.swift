//
//  footerView.swift
//  Refresh
//
//  Created by 11111 on 2016/12/25.
//  Copyright © 2016年 ZheJiang WanHang Mdt InfoTech CO.,Ltd. All rights reserved.
//

import UIKit

class footerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initData()
        initUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -----GlobalVar-----
    
    var cell : UIView!
    var cellState : Int!
    var cellLatState : Int!
    
    var ViewWidth : CGFloat!
    var ViewHeight : CGFloat!
    
    var footinitY : CGFloat!
    
    var thirtyCos : CGFloat!
    var thirtySin : CGFloat!
    
    public dynamic var footRefrshStatus : String!
    
    //MARK: -----initUI-----
    func initData() {
        ViewWidth = self.bounds.size.width
        ViewHeight = self.bounds.size.height
        self.backgroundColor = UIColor.clear
        self.isHidden = true
        footRefrshStatus = "normal"
        cellLatState = 0
        footinitY = self.center.y
    }
    
    //MARK: -----initUI-----
    func initUI() {
        
        for index in 0..<12 {
            cell = UIView.init()
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 1.0;
            cell.backgroundColor = ColorMethodho(hexValue: 0xb2b2b2)
            cell.tag = index + 1
            self .addSubview(cell)
        }
        CreateStaLoadWith(inner: 5, outside: 10)
    }
    
    //MARK: -----initLoadCellLoacation-----
    func CreateStaLoadWith(inner : Double,outside : Double) {
        
        
        
        let cellLength : CGFloat = CGFloat.init(outside - inner)
        let centerRadiu : Double = inner + Double.init(cellLength)/2
        let radiuFloat : CGFloat = CGFloat.init(centerRadiu)
        
        thirtyCos = CGFloat.init(centerRadiu * cos(M_PI/6))
        thirtySin = CGFloat.init(centerRadiu * sin(M_PI/6))
        
        for teCell in self.subviews {
            switch teCell.tag {
            case 1:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1, y: ViewHeight - cellLength, width: 2, height: cellLength)
            case 12:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 + thirtySin, y: ViewHeight - cellLength - (radiuFloat - thirtyCos), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI/6))
            case 11:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 + thirtyCos, y: ViewHeight - cellLength - (radiuFloat - thirtySin), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI/3))
            case 10:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 + radiuFloat, y: ViewHeight - cellLength - radiuFloat, width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI_2))
            case 9:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 + thirtyCos, y: ViewHeight - cellLength - (radiuFloat + thirtySin), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(M_PI/3))
            case 8:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 + thirtySin, y: ViewHeight - cellLength - (radiuFloat + thirtyCos), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(M_PI/6))
            case 7:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1, y: ViewHeight - cellLength - radiuFloat * 2, width: 2, height: cellLength)
            case 6:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 - thirtySin, y: ViewHeight - cellLength - (radiuFloat + thirtyCos), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI/6))
            case 5:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 - thirtyCos, y: ViewHeight - cellLength - (radiuFloat + thirtySin), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI/3))
            case 4:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 - radiuFloat, y: ViewHeight - cellLength - radiuFloat, width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(-M_PI_2))
            case 3:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 - thirtyCos, y: ViewHeight - cellLength - (radiuFloat - thirtySin), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(M_PI/3))
            case 2:
                teCell.frame = CGRect.init(x: ViewWidth/2 - 1 - thirtySin, y: ViewHeight - cellLength - (radiuFloat - thirtyCos), width: 2, height: cellLength)
                teCell.transform = CGAffineTransform.init(rotationAngle: CGFloat.init(M_PI/6))
            default:
                print("error")
            }
        }

        hideAllCell()
    }
    
    //MARK: -----hideAllCell-----
    func hideAllCell() {
        for teView : UIView in self.subviews{
            teView.isHidden = true
        }
    }
    
    func changeData(offset : CGFloat) {
        
        if offset > 12 {
            changeStaLoad(num: offset)
        }
    }
    
    //MARK: -----changCellStatus-----
    public func changeStaLoad(num : CGFloat){
        
        if num < 61 {
            
            cellState = (Int.init(num) - 12)/4 + 1
            changeCellState(nowState: cellState)
            cellLatState = cellState
            
            changeFootCenter(num: num)
        }else{
            changeFootCenter(num: 60)
            hideAllCell()
        }
    }
    
    func changeCellState(nowState : Int) {
        
        let needEmpty : Bool = cellLatState - nowState >= 0 ? true : false
        var showCount : Int = 0
        
        for teView : UIView in self.subviews {
            if teView.tag > 0 && teView.tag < 13 {
                if teView.tag <= nowState {
                    showCount = showCount + 1
                    teView.isHidden = false
                    print(teView.tag)
                }
                
                if needEmpty {
                    if teView.tag > nowState && teView.tag <= cellLatState {
                        showCount = showCount + 1
                        teView.isHidden = true
                    }
                }
                
                //是否跳出循环
                if needEmpty {
                    if showCount == cellLatState {
                        break
                    }
                }else{
                    if showCount == nowState {
                        break
                    }
                }
            }
        }
        
    }
    
    func changeFootCenter(num : CGFloat) {
        let initcenterx = self.center.x
        let newcentery = footinitY + CGFloat.init(0.45 * num)
        self.center = CGPoint.init(x: initcenterx, y: newcentery)
        
    }
    
}
