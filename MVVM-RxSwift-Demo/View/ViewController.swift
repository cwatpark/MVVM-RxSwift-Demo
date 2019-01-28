//
//  ViewController.swift
//  MVVM-SendText
//
//  Created by Ice on 23/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    
    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var sendButtonUI: UIButton!
    
    var viewModel: DataViewModel?
    var dpBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonUI.isEnabled = false
        navigationController?.navigationBar.prefersLargeTitles = true
        //MARK: - RxSwift Basic
        self.initialSubScription()
        
        //MARK: - Subject
        //self.behavierTest()
        //self.variableTest()
        //self.publishTest()
        //self.replayTest()
        
        //MARK: - OPERATOR
        //self.mapTest()
        //self.filterTest()
        //self.mergeTest()
        //self.combineTest()
        //self.withlatestfromTest()
        //self.startwithTest()
        //self.flatmapTest()
    }
    
    //MARK: - RxSwift Basic
    
    func initialSubScription(){
        let usr = FirstNameField.rx
            .text
            .orEmpty
            .asObservable()
            .map{(str)->Bool in
                print("FirstName : \(str)")
                return str.count > 4
                
        }
        let pwd = LastNameField.rx
            .text
            .orEmpty
            .asObservable()
            .map{(str)->Bool in
                return str.count > 4
        }
        
        Observable.combineLatest(usr,pwd){
            (isValidUsr,isValidPwd) in
            return isValidUsr && isValidPwd
            }
            .bind(to: sendButtonUI.rx.isEnabled)
        
        //                    .asObservable()
        //                    .bind(to: LastNameField.rx.text)
        
        //                        .asObservable()
        //                        .subscribe(onNext: { (str) in
        //                            print("TextField1 str: [\(str)]")
        //                        })
    }
    //MARK: - Subscribe
    func behavierTest(){
        
        let bSubject = BehaviorSubject(value: 0)
        
        let subScribe1 = bSubject.subscribe(onNext: {(value) in
            print("bSubscribe1 onNext [\(value)]")
        }, onError: {(error) in
            print("bSubscribe1 onError [\(error)]")
        })
        
        bSubject.onNext(1)
        
        let subScribe2 = bSubject.subscribe(onNext: {(value) in
            print("bSubscribe22 onNext [\(value)]")
        }, onError: {(error) in
            print("bSubscribe22 onError [\(error)]")
        })
        
        bSubject.onNext(2)
        bSubject.onNext(3)
        
        let subScribe3 = bSubject.subscribe(onNext: {(value) in
            print("bSubsribe33 onNext [\(value)]")
        }, onError: {(error) in
            print("bSubscribe3 onError [\(error)]")
        })
        
        bSubject.onNext(4)
        
        do{
            try print("bSubject.value is [\(bSubject.value())]")
        }catch{
            print("Found Error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Variable
    //เหมือนกับ Subscribe เพิ่ม .asObservable() ซึ่งทำให้คนที่ไม่เคยใช้ RxSwift ใช้งานได้ง่ายขึ้น
    func variableTest(){
        
        let vSubject = Variable<Int>(0)
        
        let vSubscribe1 = vSubject.asObservable()
            .subscribe(onNext: {(value) in
                print("vSubscribe onNext [\(value)]")
            })
        
        vSubject.value = 1
        
        let vSubscribe2 = vSubject.asObservable()
            .subscribe(onNext:{(value)  in
                print("vSubscribe2 onNext [\(value)]")
            })
        
        vSubject.value = 2
        
        print("Value of vSubject [\(vSubject.value)]")
        
    }
    
    
    //MARK: - Publish Subject
    func publishTest(){
        
        let pSubject = PublishSubject<Int>()
        
        pSubject.onNext(0)
        
        let pSubscribe1 = pSubject.asObserver()
            .subscribe(onNext: {(value) in
                print("pSubscribe onNext : [\(value)]")
            })
        
        pSubject.onNext(1)
        
        let pSubscribe2 = pSubject.asObserver()
            .subscribe(onNext: {(value) in
                print("pSubscribe2 onNext : [\(value)]")
            })
        
        pSubject.onNext(2)
        
        let pSubscribe3 = pSubject.asObserver()
            .subscribe(onNext: {(value) in
                print("pSubscribe3 onNext : [\(value)]")
            })
        
        pSubject.onNext(3)
        
    }
    
    //MARK: - Replay Subject
    func replayTest(){
        //let rSubject = ReplaySubject<Int>.create(bufferSize: 3)  //<--ขนาดที่จำได้ 3 ตัว
        let rSubject = ReplaySubject<Int>.createUnbounded()
        
        rSubject.onNext(0)
        rSubject.onNext(1)
        rSubject.onNext(2)
        
        let rSubscribe1 = rSubject.subscribe(onNext: {(value) in
            print("rSubscribe onNext : [\(value)]")
        })
        
        rSubject.onNext(3)
        
        let rSubscribe2 = rSubject.subscribe(onNext: {(value) in
            print("rSubscribe2 onNext : [\(value)]")
        })
        
        rSubject.onNext(4)
        
        let rSubscribe3 = rSubject.subscribe(onNext: {(value) in
            print("rSubscribe3 onNext : [\(value)]")
        })
        
    }
    
    //MARK: - Operator
    //MARK: - MAP Operator
    func mapTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        
        let mapSubscribe = myStream
            .map{(value)-> String in
                return "The Value IS : \(value)"
            }
            .subscribe(onNext:{(value) in
                print("On Next : [\(value)]")
            })
        
        myStream.onNext(7)
        myStream.onNext(9)
        
        let mapSubscribe2 = myStream
            .map{(value)-> String in
                return "The Value2 IS : \(value)"
            }
            .subscribe(onNext:{(value) in
                print("On Next2 : [\(value)]")
            })
        
    }
    
    //MARK: - FILTER OPERATOR
    func filterTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        
        let filterSubscribe = myStream
            .filter{(value) -> Bool in
                return value > 2
            }
            .map{(value) -> String in
                return "This Number is : [\(value)]"
            }
            .subscribe(onNext: {(value) in
                print("On Next : [\(value)]")
            })
        
        myStream.onNext(1)
        myStream.onNext(2)
        myStream.onNext(3)
        myStream.onNext(4)
        myStream.onNext(6)
        myStream.onNext(2)
        myStream.onNext(70)
        
        let filterSubscribe2 = myStream
            .filter{(value) -> Bool in
                return value > 0
            }
            .map{(value) -> Bool in  // เปลี่ยนเป็น True False
                return value > 2
            }
            .subscribe(onNext: {(value) in
                print("On Next : [\(value)]")
            })
    }
    
    //MARK: - MERGE OPERATOR
    func mergeTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        let secondStream = BehaviorSubject<Int>(value: 100)
        
        let mergeSubscribe = Observable.merge([
            myStream.asObserver(),
            secondStream.asObserver()
            ]).subscribe(onNext:{(value) in
                print("On Next : [\(value)]")
            })
        
        myStream.onNext(1)
        secondStream.onNext(99)
        secondStream.onNext(98)
        secondStream.onNext(97)
        myStream.onNext(2)
        myStream.onNext(3)
        
    }
    
    //MARK: - COMBINELATEST OPERATOR
    func combineTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        let messageStream = BehaviorSubject<String>(value: "A")
        
        let combineSubscribe = Observable.combineLatest(myStream,messageStream)
        { (valueOfMyStream,valueOfMessageStream) -> String in
            return "MyStream \(valueOfMyStream) MessageStream \(valueOfMessageStream)"
            }
            .subscribe(onNext: {(value) in
                print("On Next: [\(value)]")
            })
        
        messageStream.onNext("BB")
        myStream.onNext(1)
        myStream.onNext(2)
        myStream.onNext(3)
        messageStream.onNext("CC")
        myStream.onNext(4)
        
    }
    
    //MARK: - WITHLATESTFROM
    func withlatestfromTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        let messageStream = BehaviorSubject<String>(value: "A")
        
        let withLatestStreamSubscribe = myStream.withLatestFrom(messageStream, resultSelector:
        { (valueOfMyStream,valueOfMessageStream) -> String in
            return "MyStream \(valueOfMyStream) MessageStream \(valueOfMessageStream) "
        })
            .subscribe(onNext: {(value) in
                print("On Next: [\(value)]")
            })
        
        messageStream.onNext("BB")
        myStream.onNext(1)
        messageStream.onNext("CC")
        messageStream.onNext("DD")
        myStream.onNext(2)
        
    }
    
    //MARK: - STARTWITH
    func startwithTest(){
        let myStream = BehaviorSubject<Int>(value: 0)
        let startWithSubScribe = myStream
            .filter{(value) -> Bool in
                return value > 2
            }
            .startWith(0)
            .map{(value) -> String in
                return "My Number Is : [\(value)]"
            }
            .startWith("3453145")
            .subscribe(onNext: {(value) in
                print("On next : [\(value)]")
            })
        
        myStream.onNext(1)
        myStream.onNext(2)
        myStream.onNext(3)
        myStream.onNext(4)
        
    }
    
    //MARK: - FlatMap
    func flatmapTest(){
        let pSubject = PublishSubject<String>()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        
        let conQueue = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
        let fObservable = pSubject
            .asObservable()
            .observeOn(conQueue)
            .flatMap { (value) -> Observable<String> in
                return Observable
                    .create({ (observer) -> Disposable in
                        DispatchQueue.global().async {
                            observer.onNext("\(value)] [1st time")
                        }
                        
                        DispatchQueue.global().sync {
                            observer.onNext("\(value)] [2nd time")
                        }
                        
                        DispatchQueue.global().sync {
                            observer.onNext("\(value)] [3rd time")
                        }
                        
                        return Disposables.create()
                    })
                    .observeOn(conQueue)
        }
        
        let subscribe = fObservable
            .subscribe(onNext: {(result) in
                //print("\(DateFormatter.string(from: Date())) [\(result)] ")
                print("\(dateFormatter.string(from: Date())) [\(result)]")
            })
        
        pSubject.onNext("❤️")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
            pSubject.onNext("💛")
        })
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2), execute: {
            pSubject.onNext("💚")
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirstNameField.text = ""
        LastNameField.text = ""
        sendButtonUI.isEnabled = false
    } 
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showTextStoryBoard") as! ShowViewController
        
        viewModel = DataViewModel(Fname: FirstNameField.text!, Lname: LastNameField.text!)
        showVC.ShowData = viewModel
        
        self.navigationController?.pushViewController(showVC, animated: true)
        
        
    }
    
    
    
    
}


