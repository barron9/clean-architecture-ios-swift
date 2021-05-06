
import Foundation
import RxSwift
import RxCocoa

protocol NetworkingService {
    func performLogin(withQuery query: String, pass:String) -> Observable<DataResponse>
    func getPortfolio(withQuery query: String, pass:String, accId:String) -> Observable<[StocksDataItem]>
}

final class NetworkingApi: NetworkingService {
    func performLogin(withQuery query: String, pass:String) -> Observable<DataResponse> {
        NSLog("call to login service \(query) \(pass)")
        let request = URLRequest(url: URL(string: "https://tbpilot.matriksdata.com/9999/Integration.aspx?MsgType=A&CustomerNo=0&Username=\(query)&Password=\(pass)&AccountID=0&ExchangeID=4&OutputType=2")!)
        return URLSession.shared.rx.data(request: request)
            .map { data -> DataResponse in
                guard let response = try? JSONDecoder().decode(DataResponse.self, from: data) else { return DataResponse(Result: MatriksResult(State: false,Description: "unknown error occured"),DefaultAccount: "") }
                NSLog(response.DefaultAccount)
                return response
            }
    }
    
    func getPortfolio(withQuery query: String, pass:String, accId:String) -> Observable<[StocksDataItem]> {
        let request = URLRequest(url: URL(string: "https://tbpilot.matriksdata.com/9999/Integration.aspx?MsgType=AN&CustomerNo=0&Username=\(query)&Password=\(pass)&AccountID=\(accId)&ExchangeID=4&OutputType=2")!)
        return URLSession.shared.rx.data(request: request)
            .map { data -> [StocksDataItem] in
                NSLog("...caling")
                guard let response = try? JSONDecoder().decode(StocksDataResponse.self, from: data) else { return  [] }
                NSLog("...%i",response.Item.count)
                return response.Item
            }
    }
    
}



