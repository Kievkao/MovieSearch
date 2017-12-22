# iOS-Assignment
iOS Assignment

Use Carthage to install dependencies:
https://github.com/Carthage/Carthage


Used third-party libraries:
1) RxSwift
https://github.com/ReactiveX/RxSwift
2) Alamofire
https://github.com/Alamofire

*Brief architecture description:*  
Basic approach is MVVM with Reactive.  
Each UIViewController and UITableViewCell have own ViewModel (excluding cases when there is no logic to prepare data for displaying).  
Navigation between screen is performing by Flow Controller (in this implementation - by just one).  
View Models have an handlers interface to communicate with Flow Controllers.  
Each object has an protocol for defining public interface. It particularly allows to mock them for testing purposes and get rid from exact classes usage.  
All main dependencies are created in AppDelegate and are passed as DI to next screens.
