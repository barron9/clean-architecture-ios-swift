

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Bool>
        let username_text: Driver<String>
        let password_text: Driver<String>
        let loginbutton: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let repos: Driver<DataResponse>
    }
    
    struct Dependencies {
        let networking: NetworkingService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let username = Variable<String>("")
        let password = Variable<String>("")
        _ = input.username_text.asObservable().bind(to: username)
        _ = input.password_text.asObservable().bind(to: password)
        let loginprocess = input.loginbutton
            .flatMapLatest({
                status in
                self.dependencies.networking
                    .performLogin(withQuery: username.value , pass:password.value)
                    .trackActivity(loading)
                    .asDriver(onErrorJustReturn: DataResponse(Result: MatriksResult(State: false,Description: "unknown error occured"),DefaultAccount: ""))
            })
        let repos = Driver.merge(loginprocess)
        return Output(loading: loading.asDriver(),
                      repos: repos)
    }
}


