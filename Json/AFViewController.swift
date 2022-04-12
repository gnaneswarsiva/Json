//
//  AFViewController.swift
//  Json
//
//  Created by lakshmi Raghavendra on 05/03/21.
//

import UIKit
import Alamofire
import MobileCoreServices

class AFViewController: UIViewController {
    
    struct  RequestBodyFormDataKeyValue {
        var sKey:String
        var sValue:String
        var dBlockData : Data
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getBtn(_ sender: Any) {
    }
    @IBAction func postBtn(_ sender: Any) {
        var bodyKeyValue = [RequestBodyFormDataKeyValue]()
        
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "a", sValue: "b", dBlockData: Data()))
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "c", sValue: "d", dBlockData: Data()))
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "e", sValue: "f", dBlockData: Data()))
        
        let oArrArray = "NGOMap.jpg".components(separatedBy: ".")//[0] Name; [1] Extension
        
        let mimeType = self.returnMimeType(fileExtension: oArrArray[1])
        
        let oImage = UIImage(named: "NGOMap.jpg")
        
        let dData = oImage?.pngData() // data format
        
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "file", sValue: "NGOMap.jpg", dBlockData: dData!))

        var sURL:String!
        sURL = "https://httpbin.org/post"
        
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200,204,205]))
        var sampleRequest = URLRequest(url: URL(string: sURL)!)
        sampleRequest.httpMethod = HTTPMethod.post.rawValue
        
        AF.upload(multipartFormData: {multiFormData in
            for formData in bodyKeyValue
            {
                if formData.dBlockData.isEmpty
                {
                    multiFormData.append(Data(formData.sValue.utf8), withName: formData.sKey)
                }
                else
                {
                    multiFormData.append(formData.dBlockData, withName: formData.sKey,fileName: "NGOMap.jpg",mimeType: mimeType)
                }
            }
        }, to: sURL, method: .post)
        .uploadProgress { (Progress) in
            print(CGFloat(Progress.fractionCompleted)*100)
        }
        .response{response in
            if response.error == nil
            {
                var responseString:String!
                responseString = ""
                
                if response.data != nil
                {
                    responseString = String(bytes: response.data!, encoding: .utf8)
                }
                else
                {
                    responseString = response.response?.description
                }
                print(responseString ?? "")
                print(response.response?.statusCode)
                var resposeData:NSData!
                resposeData = response.data! as NSData
                var iDataLength = resposeData.length
                print("Size:\(iDataLength) Bytes")
                
                print("Response Time:\(response.metrics?.taskInterval.duration ?? 0) seconds")
            }
        }
        
        
     /*   AF.request(sampleRequest).uploadProgress { (Progress) in
        }.response(responseSerializer: serializer) { (response) in
            if response.error == nil {
                var responseString:String!
                responseString = ""
                if response.data != nil {
                    responseString = String(bytes: (response.data)!, encoding: .utf8)
                }
                else {
                    responseString = response.response?.description
                }
                print(responseString ?? "")
                print(response.response?.statusCode)
                var resposeData:NSData!
                resposeData = response.data! as NSData
                var iDataLength = resposeData.length
                print("Size:\(iDataLength) Bytes")
                
                print("Response Time:\(response.metrics?.taskInterval.duration ?? 0) seconds")
            }
        }*/
        
    }
    
    func returnMimeType(fileExtension:String) -> String
    {
        if let oUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue()
        {
            if let mimeType = UTTypeCreatePreferredIdentifierForTag(oUTI, kUTTagClassMIMEType, nil)?.takeRetainedValue()
            {
                return mimeType as String
            }
        }
        return ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
