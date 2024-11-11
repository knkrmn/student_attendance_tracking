// View/Log_absenceView.swift
import UIKit

class LogAbsenceView: UIView {

    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LogCell.self, forCellReuseIdentifier: "CustomCell")
        return table
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let datePickerContainer = UIView()
        datePickerContainer.backgroundColor = .systemGray6
        datePickerContainer.layer.cornerRadius = 12
        datePickerContainer.layer.shadowColor = UIColor.black.cgColor
        datePickerContainer.layer.shadowOpacity = 0.1
        datePickerContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        datePickerContainer.layer.shadowRadius = 4
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePickerContainer)

        datePickerContainer.addSubview(datePicker)
        addSubview(saveButton)
        addSubview(tableView)

        NSLayoutConstraint.activate([
            datePickerContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            datePickerContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePickerContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datePickerContainer.heightAnchor.constraint(equalToConstant: 50),

            datePicker.topAnchor.constraint(equalTo: datePickerContainer.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor, constant: -8),

            tableView.topAnchor.constraint(equalTo: datePickerContainer.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
