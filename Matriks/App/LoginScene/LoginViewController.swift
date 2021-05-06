
import UIKit
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {
    var viewModel:  LoginViewModel!
    
    private let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var password_text: UITextField!
    @IBOutlet weak var loginbutton: UIButton!
    private var performseguecheck = BehaviorRelay(value: false);
    private let searchTextField = UITextField()
    
    @IBOutlet weak var username_text: UITextField!
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        username_text.text = ""
        password_text.text = ""
        self.viewModel = (LoginViewModel(dependencies: LoginViewModel.Dependencies(networking: NetworkingApi())))
        bindViewModel()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginsegue" && performseguecheck.value{
            return true;
        }
        return false;
    }
    
    private func bindViewModel() {
        let input = LoginViewModel.Input(ready: rx.base.performseguecheck.asDriver(),
                                         username_text: username_text.rx.text.orEmpty.asDriver(),
                                         password_text: password_text.rx.text.orEmpty.asDriver(),
                                         loginbutton: loginbutton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.repos.drive(onNext:{
            ree in
            NSLog("onnext for  \(ree)")
            if(!ree.Result.State){
                let alert = UIAlertController(title: "hata!", message: ree.Result.Description, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "yeniden dene", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let defaults = UserDefaults.standard
                defaults.set(self.username_text.text, forKey: "username")
                defaults.set(self.password_text.text, forKey: "password")
                defaults.set(ree.DefaultAccount, forKey: "accId")
                self.performSegue(withIdentifier: "loginsegue",sender: nil)
            }
        },onCompleted:{
            NSLog("oncompleted for ")
        })
        .disposed(by: disposeBag)
        
    }
}
