import UIKit

class LogCell: UITableViewCell {
    
    // MARK: - Properties
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attendanceCheckBox: UISwitch = {
        let checkBox = UISwitch()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    var student: Student! {
        didSet {
            name.text = student.name
            attendanceCheckBox.isOn = student.isChecked
        }
    }
    

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
        attendanceCheckBox.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupViews() {
        contentView.addSubview(name)
        contentView.addSubview(attendanceCheckBox)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            attendanceCheckBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            attendanceCheckBox.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc private func switchValueChanged() {
        student.isChecked = attendanceCheckBox.isOn // Durumu güncelle
    }
}
