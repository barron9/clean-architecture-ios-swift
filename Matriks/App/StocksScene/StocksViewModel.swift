

import RxSwift
import RxCocoa

final class StocksViewModel {
    struct Input {
        let ready: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let repos: Driver<[StocksDataItem]>
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
        let defaults = UserDefaults.standard

        let initportfoy = input.ready
            .flatMap { _ in
                self.dependencies.networking
                    .getPortfolio(
                        withQuery: defaults.string(forKey: "username") ?? "",
                        pass: defaults.string(forKey: "password") ?? "",
                        accId: defaults.string(forKey: "accId") ?? "")
                    .trackActivity(loading)
                    .asDriver(onErrorJustReturn: [])
            }

        let repos = Driver.merge(initportfoy)
      
        return Output(loading: loading.asDriver(), repos: repos)
    }
}


