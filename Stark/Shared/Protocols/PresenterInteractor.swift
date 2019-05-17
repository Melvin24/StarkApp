import Foundation

/// An interface which defines the basic setup of the viewController.
protocol PresenterInteractor: class {
    
    associatedtype PresenterType: Presenter
    
    /// Associated presenter.
    var presenter: PresenterType! { get }
    
}
