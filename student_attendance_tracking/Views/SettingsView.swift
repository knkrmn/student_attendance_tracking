import UIKit

class SettingsView: UIView {
    lazy var logOutButton = CustomButton(title: "Logout")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
