import UIKit

class StudentDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let studentService = StudentService()
    var students: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        getAllStudents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllStudents()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]
        
        let studentDetailView = StudentDetailViewController()
        studentDetailView.choosenStudent = selectedStudent
        
        navigationController?.pushViewController(studentDetailView, animated: true)
    }
    
    // Helpers
    private func getAllStudents() {
        studentService.fetchStudents { [weak self] students in
            guard let self = self else { return }
            
            self.students = students
            print("Student detail - getAllStudents", students.count)
            
            self.students.sort { student1, student2 in
                return student1.name < student2.name
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
