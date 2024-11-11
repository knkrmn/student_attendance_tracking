import UIKit

class StudentDetailViewController: UIViewController {
    
    var choosenStudent: Student?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Student Name"
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        name.text = choosenStudent?.name ?? "No student chosen"
    }
    
    private func setupView() {
        nameStackView.addArrangedSubview(label)
        nameStackView.addArrangedSubview(name)
        
        view.addSubview(nameStackView)
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
