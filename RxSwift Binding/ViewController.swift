//
//  ViewController.swift
//  RxSwift Binding
//
//  Created by Andrew on 9/6/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    var intArray: BehaviorRelay<Int> = BehaviorRelay(value: .zero)
    var stringArray: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindIntArrayToLabel()
        bindStringArrayToLabel()
    }
    
    @IBAction func addItemToIntArray(_ sender: UIButton) {
        let randomInt = Int.random(in: 1...10)
        intArray.accept(randomInt)
        print(randomInt)
    }
    
    @IBAction func addItemToStringArray(_ sender: UIButton) {
        let alphabet = ["a", "b", "c", "d", "z"]
        let randomChar = alphabet.randomElement() ?? "@"
        stringArray.accept(randomChar)
        print(randomChar)
    }
    
    func bindIntArrayToLabel() {
        intArray
            .asObservable()
//            .map { $0 * 10 }
            .subscribe(onNext: { intStream in
                self.label.text = String(intStream)
            })
            .disposed(by: disposeBag)
    }
    
    func bindStringArrayToLabel() {
        stringArray.asObservable().bind(to: label.rx.text).disposed(by: disposeBag)
    }

}

