

import Foundation
struct MatriksResult : Decodable {
   let State : Bool
   let Description : String
}
struct DataResponse: Decodable {
   let Result: MatriksResult
   let DefaultAccount: String
}
