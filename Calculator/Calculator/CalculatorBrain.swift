//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Junseok Lee on 2021/08/26.
//

import Foundation

class CalcuratorBrain{
    
    private var accumulator: Double = 0.0
    private var internalProgram = [AnyObject]()
    
    func setOpernand(operand: Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    private var operatons: Dictionary<String,Operation> = [
        "π" : Operation.Constant(.pi),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "ⅹ" : Operation.BinaryOperation{$0 * $1},
        "+" : Operation.BinaryOperation{$0 + $1},
        "-" : Operation.BinaryOperation{$0 - $1},
        "÷" : Operation.BinaryOperation{$0 / $1},
        "=" : Operation.Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    
    
    func performOperation(symbol: String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operatons[symbol]{
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction:(Double,Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList{
        get{
            return internalProgram as AnyObject
        }
        set{
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps{
                    if let operand = op as? Double{
                        setOpernand(operand: operand)
                    } else if let operation = op as? String{
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
}
