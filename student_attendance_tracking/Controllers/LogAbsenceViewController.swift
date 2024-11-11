import UIKit

class Log_absenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    var tableView: UITableView!
    private var students: [Student] = []
    private let studentService = StudentService()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStudents()
        
        
    }
    
    // MARK: - Setup TableView
    
    private func setupUI() {
        // DatePicker Container View
        let datePickerContainer = UIView()
        datePickerContainer.backgroundColor = .systemGray6
        datePickerContainer.layer.cornerRadius = 12
        datePickerContainer.layer.shadowColor = UIColor.black.cgColor
        datePickerContainer.layer.shadowOpacity = 0.1
        datePickerContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        datePickerContainer.layer.shadowRadius = 4
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label for DatePicker
        let datePickerTitle = UILabel()
        datePickerTitle.text = "Date"
        datePickerTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        datePickerTitle.textAlignment = .center
        datePickerTitle.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainer.addSubview(datePickerTitle)
        
        // DatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact // Takvim görünümü
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainer.addSubview(datePicker)
        
        // Save Button
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Kaydet", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        // TableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LogCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Container StackView
        let containerView = UIStackView(arrangedSubviews: [datePickerContainer, tableView, saveButton])
        containerView.axis = .vertical
        containerView.spacing = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            datePickerContainer.heightAnchor.constraint(equalToConstant: 50),
            
            datePickerTitle.topAnchor.constraint(equalTo: datePickerContainer.topAnchor, constant: 10),
            datePickerTitle.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor, constant: 8),
            datePickerTitle.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor, constant: -8),
            
            datePicker.topAnchor.constraint(equalTo: datePickerContainer.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    // Save Button Action
    @objc private func saveButtonTapped() {
        let selectedDate = datePicker.date

        // Date’i belirli bir formatta yazdırmak için formatter kullanabiliriz
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Seçilen Tarih: \(formattedDate)")
    }
    
    
    
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? LogCell else {
            return UITableViewCell()
        }
        
        let student = students[indexPath.row]
        //cell.studentID.text = String(student.studentID)
        cell.name.text = student.name
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods (isteğe bağlı)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Hücre seçildiğinde yapılacak işlemler
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func fetchStudents() {
        studentService.fetchStudents { [weak self] students in
            self?.students = students
            print("students",students.count)
            
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        setupUI()

    }
}
