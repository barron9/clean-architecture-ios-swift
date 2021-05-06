
import UIKit

class StockCell: UITableViewCell {

    @IBOutlet var price: UILabel!
    @IBOutlet  var stockname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        price.text = "12"
        stockname.text = "abc"
        quantity.text = "33"
        // Initialization code
    }
    @IBOutlet  var quantity: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
