//
//  ViewController.swift
//  03Map_Pin_Plist
//
//  Created by D7702_09 on 2017. 9. 19..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

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
                
                // delegate 적용시키기
                myMapView.delegate = self
                
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // pin 재활용
        let identifier = "MyPin"
        var  annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // annotation의 title값에 대해서 일치하면 이미지와 calloutAccessory를 실행.
            if annotation.title! == "부산시민공원" {
                // 부산시민공원
                annotationView?.pinTintColor = UIColor.green
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                leftIconView.image = UIImage(named:"citizen_logo.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            } else if annotation.title! == "DIT 동의과학대학교" {
                // 동의과학대학교
                annotationView?.pinTintColor = UIColor.red
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"DIT_logo.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            } else if annotation.title! == "송상현광장" {
                // 송상현광장
                annotationView?.pinTintColor = UIColor.blue
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"Songsang.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            } else if annotation.title! == "부산여자대학교" {
                // 부산여자대학교
                annotationView?.pinTintColor = UIColor.yellow
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"Busan_logo.png" )
                annotationView?.leftCalloutAccessoryView = leftIconView
            
            } else if annotation.title! == "양정역" {
                // 양정역
                annotationView?.pinTintColor = UIColor.black
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                leftIconView.image = UIImage(named:"subway_logo.jpeg" )
                annotationView?.leftCalloutAccessoryView = leftIconView

            }
            
            }else {
                annotationView?.annotation = annotation
            }
        
        /* 애니메이션 부분 적용 안되서 주석처리
        
        //pin에 애니메이션을 적용시킴(위에서 아래로 떨어지는 애니메이션 추가).
        annotationView?.animatesDrop = true
        
        //leftcalloutAcceary
        annotationView?.canShowCallout = true
         
        */
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        
 
        
        return annotationView
        
    }
    
    // callout accessary를 눌렀을때 alert View 보여줌
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("callout Accessory Tapped!")
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let viewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        print("\(viewTitle) \(viewSubTitle)")
        
        let ac = UIAlertController(title: viewTitle, message: viewSubTitle, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

}

