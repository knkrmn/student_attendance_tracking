
import UIKit
import FirebaseAuth

class StudentDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let studentService = StudentService()

    lazy var loginViewController : LoginViewController = {
        return LoginViewController()
    }()
    
    var choosenStudent: Student?
    var calendarDays: [String] = []
    var attendanceMap: [String: Bool?] = [:]

    // UI Elements
    private let nameLabel: UILabel = createLabel(text: "Student Name :")
    private let idLabel: UILabel = createLabel(text: "Student Id :")
    private let name = UILabel()
    private let id = UILabel()

    private let idStackView = createStackView()
    private let nameStackView = createStackView()
    private let mainStackView = createVerticalStackView()
    private let collectionView: UICollectionView = createCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let parentMail = Auth.auth().currentUser!.email!
        studentService.getStudentFromParentMail(parentMail: parentMail) { student in
            
            if let student = student {
                
                DispatchQueue.main.async { [self] in
                    self.choosenStudent = student
                    setUpAttendanceMap()
                    if let student = choosenStudent {
                        name.text = student.name
                        id.text = String(student.studentID)
                    } else {
                        name.text = "No student chosen"
                        id.text = "No student chosen"
                    }
                    
                    collectionView.reloadData()
            
                }
            } else {
                print("Öğrenci bulunamadı")
            }
        }
        
        setupView()

        if let student = choosenStudent {
            name.text = student.name
            id.text = String(student.studentID)
        } else {
            name.text = "No student chosen"
            id.text = "No student chosen"
        }

        setUpAttendanceMap()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = .white
        
        if let student = choosenStudent {
            name.text = student.name
            id.text = String(student.studentID)
        } else {
            name.text = "No student chosenn"
            id.text = "No student chosenn"
        }
        
        setUpAttendanceMap()
        collectionView.reloadData()
    }

    private func setupView() {
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(name)

        idStackView.addArrangedSubview(idLabel)
        idStackView.addArrangedSubview(id)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)

        mainStackView.addArrangedSubview(idStackView)
        mainStackView.addArrangedSubview(nameStackView)
        mainStackView.addArrangedSubview(collectionView)

        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            collectionView.widthAnchor.constraint(equalToConstant: 400),
        ])
    }

    func setUpAttendanceMap() {
        guard let student = choosenStudent else { return }
        calendarDays = []

        let calendar = Calendar.current
        let currentDate = Date()

        let range = calendar.range(of: .day, in: .month, for: currentDate)
        let daysInMonth = range?.count ?? 30

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)

        for day in 1...daysInMonth {
            let dayString = String(day)
            calendarDays.append(dayString)

            let dateString = String(format: "%04d-%02d-%02d", year, month, day)

            if let attendance = student.attendanceRecords.first(where: { $0.date == dateString }) {
                attendanceMap[dayString] = attendance.is_present
            } else {
                attendanceMap[dayString] = nil
            }
        }
    }

    // MARK: - UICollectionViewDataSource Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as! DayCell

        let day = calendarDays[indexPath.row]
        //
        if let isPresent = attendanceMap[day] {
            cell.configure(with: day, isPresent: isPresent)
            print(isPresent!)
        } else {
            cell.configure(with: day, isPresent: nil) // Opsiyonel bir işlem yapılabilir.
        }
        
        return cell
    }
}

// MARK: - Helper UI Methods

private func createLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    return label
}

private func createStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}

private func createVerticalStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}

private func createCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 40, height: 40)
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 5
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
}

// MARK: - UICollectionViewCell Subclass

class DayCell: UICollectionViewCell {

    static let reuseIdentifier = "dayCell"

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with day: String, isPresent: Bool?) {
        label.text = day
        
        // Renkleri duruma göre ayarla
        if let isPresent = isPresent {
            contentView.backgroundColor = isPresent ? .green : .red
        } else {
            contentView.backgroundColor = .gray // Devamsızlık bilgisi yoksa gri yap
        }
    }

}
