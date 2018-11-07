import UIKit
import Foundation

let url = URL(string: "https://www.mocky.io/v2/5b33bdb43200008f0ad1e256")!

class TransactionResponse: Decodable {

    var data: [Transaction]

    enum TransactionsKey: CodingKey {
        case data
    }
}

class Transaction: Decodable {
    var id: String
    var date: String
    var description: String
    var categoryId: Int
    var currency: String
    var amount: Amount
    var product: Product

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case categoryId = "category_id"
        case currency
        case amount
        case product
    }
}

struct Amount: Decodable {
    var value: Double
    var currencyIso: String

    private enum CodingKeys: String, CodingKey {
        case value
        case currencyIso = "currency_iso"
    }
}

struct Product: Decodable {
    var id: Int
    var title: String
    var iconUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case iconUrl = "icon"
    }
}

let transactions:TransactionResponse? = nil

func sendRequest() {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            DispatchQueue.main.async {
                print("Error")
            }
            return
        }

        do {
            let decoder = JSONDecoder()
            let transactions = try decoder.decode(TransactionResponse.self, from: data)
            print(transactions.data.count)
        } catch _ {
            DispatchQueue.main.async {
                print("Error")
            }
        }
    }

    task.resume()
}

sendRequest()
