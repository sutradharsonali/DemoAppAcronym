//
//  Observable.swift


import Foundation

// MARK :- Observable class to bind data and view

class Observable<T>{
    var value : T?{
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener:  @escaping (T?) -> Void){
        listener(value)
        self.listener = listener
    }
}
