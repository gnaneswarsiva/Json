//
//  CodableViewController.swift
//  Json
//
//  Created by lakshmi Raghavendra on 25/03/22.
//

import UIKit


struct HttpUtility {
    
    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T) -> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if error == nil && responseData != nil && responseData?.count != 0
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do
                {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result)
                }
                catch
                {
                    print("error \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
class CodableViewController: UIViewController {

    var httpUtility = HttpUtility()
    //constructor injection
//    init(_httpUtility: HttpUtility) {
//        self.httpUtility = _httpUtility
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeeData()
    }
    
    func getEmployeeData()
    {
        
        let employeeApiUrl = "https://jsonplaceholder.typicode.com/todos/"
        
        let url = URL(string: employeeApiUrl)
        
        httpUtility.getApiData(requestUrl: url!, resultType: [UserModel].self) { (userResult) in
            if userResult.count != 0
            {
                for model in userResult
                {
                    print(model.title)
                }
            }
            
        }
//        URLSession.shared.dataTask(with: url!) { (responseData, httpUrlResponse, error) in
//            if error == nil && responseData != nil && responseData?.count != 0
//            {
//                //parse the responseData here
//                do
//                {
////                    let response = try JSONSerialization.jsonObject(with: responseData!, options: [])
//                    let decoder = JSONDecoder()
//                    let result = try decoder.decode([UserModel].self, from: responseData!)
//                    for model in result
//                    {
//                        print(model.title)
//                    }
//                    print(result)
//
//                }
//                catch
//                {
//                    print("Catch \(error.localizedDescription)")
//                }
//
//            }
//        }.resume()
    }
    
    
    

}
