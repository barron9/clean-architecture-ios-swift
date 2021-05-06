
import UIKit
import RxSwift
import RxCocoa

class StocksViewController: UIViewController, UITableViewDelegate {
        
    var viewModel:  StocksViewModel!
    
    @IBOutlet weak var stockstable_view: UITableView!
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: StocksViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.viewModel = (StocksViewModel(dependencies: StocksViewModel.Dependencies(networking: NetworkingApi())))
        bindViewModel()
    }
  
    @IBOutlet weak var newbalance: UILabel!
    
    private func bindViewModel() {
        let total = Variable<Float>(0.0)
        
        stockstable_view.register(StockCell.self, forCellReuseIdentifier: "Cell")
    
        let input = StocksViewModel.Input(ready: rx.viewWillAppear.asDriver())

        let output = viewModel.transform(input: input)
        stockstable_view.rx
                .setDelegate(self)
                .disposed(by: disposeBag)
//        output.repos
//            .asObservable().bind(to: stockstable_view.rx.items(cellIdentifier: "Cell", cellType: StockCell.self)){index, element, cell in
//                cell.textLabel?.text = element.Symbol
//                cell.price?.text = "123"
//                cell.stockname?.text = "abc"
//            }.disposed(by: disposeBag)
        
        output.repos
            .drive(stockstable_view.rx.items(cellIdentifier: "Cell", cellType: StockCell.self)) {  (row, element, cell) in
                cell.price?.text = "123"
                cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 12)
                cell.textLabel?.text =  element.Symbol
                cell.textLabel?.text! += ", " + element.LastPx.description + "TL"
                cell.textLabel?.text! += ", " + element.Qty_T2.description
                cell.textLabel?.text! += ", " + element.Amount.description + "TL"
                total.value += element.Amount
                self.newbalance.text = "Toplam: " + total.value.description + "TL"

            }
            .disposed(by: disposeBag)

    }
  
}
