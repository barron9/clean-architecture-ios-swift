
import Foundation

struct StocksResult : Decodable {
   let State : Bool
   let Description : String
}
struct StocksDataResponse: Decodable {
  // let Result: StocksResult
   let Item: [StocksDataItem]
}
struct StocksDataItem: Decodable {
   let Symbol: String
   let Qty_T2: Float
   let LastPx: Float
   let Amount: Float
}
