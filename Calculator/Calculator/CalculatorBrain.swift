//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Junseok Lee on 2021/08/26.
//

import Foundation

func multiply(op1:Double,op2:Double) -> Double{
    return op1 * op2
}

class CalcuratorBrain{
    
    private var accumulator: Double = 0.0
    
    func setOpernand(operand: Double){
        accumulator = operand
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
    
    var result: Double{
        get{
            return accumulator
        }
    }
}
