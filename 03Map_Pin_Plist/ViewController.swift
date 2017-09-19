//
//  ViewController.swift
//  03Map_Pin_Plist
//
//  Created by D7702_09 on 2017. 9. 19..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomToRegion()
        
        // plist파일 경로 찾아서 가져 오기
        let path = Bundle.main.path(forResource: "ViewPoint2", ofType: "plist")
        print("path =\(String(describing: path))")
        
        // plist 파일 내용을 가져와서 저장하기
        let contents = NSArray(contentsOfFile: path!)
        print("contents = \(String(describing: contents))")
        
        // pin 저장
        var annotations = [MKPointAnnotation]()
        
        // 
        if let myItems = contents {
            for item in myItems {
                
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                let annotation = MKPointAnnotation()
                
                // 형 변환
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                let myTitle = title as! String
                let mySubTitle = subTitle as! String
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = myTitle
                annotation.subtitle = mySubTitle
                
                // 배열에 추가하기
                annotations.append(annotation)
                
            }
        } else {
            
            // 내용이 없을때 print 표시
            print("contents is nil")
        }
        
        // showAnnotations = 핀 전체가 나오도록 center를 잡아줌.
        myMapView.showAnnotations(annotations, animated: true)
        myMapView.addAnnotations(annotations)
    }
    
    // 초기 zoom되는 장소 지정 함수
    func zoomToRegion(){
        
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        myMapView.setRegion(region, animated: true)
    }
    

}

