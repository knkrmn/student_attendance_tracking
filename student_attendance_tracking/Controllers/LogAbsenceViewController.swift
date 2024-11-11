import UIKit
import FirebaseFirestore
class LogAbsenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let studentService = StudentService()
    var students: [Student] = []
    var logAbsenceView: LogAbsenceView!
    
    var selectedDate : String  {
        return getDate()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        logAbsenceView = LogAbsenceView()
        view = logAbsenceView
        
        logAbsenceView.tableView.delegate = self
        logAbsenceView.tableView.dataSource = self
        
        logAbsenceView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        logAbsenceView.datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)

        fetchStudents()
    }
    
    
    @objc private func saveButtonTapped() {
        
        for student in students {
            if student.isChecked {
                let attendanceRecord = AttendanceRecord(date: selectedDate, is_present: true)
                studentService.saveAttendanceRecord(for: student, record: attendanceRecord)
            } else {
                let attendanceRecord = AttendanceRecord(date: selectedDate, is_present: false)
                studentService.saveAttendanceRecord(for: student, record: attendanceRecord)
            }
        }
    }


    private func fetchStudents() {
        studentService.fetchStudents { [weak self] students in
            self?.students = students
            DispatchQueue.main.async {
                self?.logAbsenceView.tableView.reloadData()
            }
        }
    }


    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? LogCell else {
            return UITableViewCell()
        }
        
        cell.student = students[indexPath.row]
        
        studentService.getAttendanceByDate(for: selectedDate, student: cell.student) { is_present in
            if let is_present = is_present {
                cell.attendanceCheckBox.isOn = is_present
                cell.student.isChecked = is_present
            } else {
                cell.attendanceCheckBox.isOn = true
                cell.student.isChecked = true
            }
        }
                
        // UISwitch için target ekleyin
         cell.attendanceCheckBox.addTarget(self, action: #selector(attendanceSwitchChanged(_:)), for: .valueChanged)
         cell.attendanceCheckBox.tag = indexPath.row // Tag kullanarak hangi hücreye ait olduğunu tutuyoruz

        return cell
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func attendanceSwitchChanged(_ sender: UISwitch) {
        let index = sender.tag
        students[index].isChecked = sender.isOn
    }
    
    
    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        for (index, student) in students.enumerated() {
            var mutableStudent = student // Değiştirilebilir bir kopya oluştur
            studentService.getAttendanceByDate(for: selectedDate, student: mutableStudent) { is_present in
                if let is_present = is_present {
                    mutableStudent.isChecked = is_present
                } else {
                    mutableStudent.isChecked = true
                }
                self.students[index] = mutableStudent // Kopyayı orijinal diziye geri at
            }
        }
        
        self.logAbsenceView.tableView.reloadData()
    }
    
    
    func getDate() -> String {
        let getDate = logAbsenceView.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: getDate)
        return formattedDate
    }
}
