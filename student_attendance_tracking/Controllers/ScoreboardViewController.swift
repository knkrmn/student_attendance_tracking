import UIKit
import FirebaseFirestore

class ScoreboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let studentService = StudentService()
    var students : [Student] = []
    var scoreboard : Scoreboard!

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        scoreboard = Scoreboard()
        view = scoreboard
        
        scoreboard.tableView.dataSource = self
        scoreboard.tableView.delegate = self
        
        getAllStudents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllStudents()
        self.scoreboard.tableView.reloadData()

    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? DashCell else {
            return UITableViewCell()
        }
        
        cell.sequence.text = String(indexPath.row + 1)
        cell.setRanking(index: indexPath.row + 1)
        cell.student = students[indexPath.row]
        cell.progressBar.progress = Float(calculatePoint(student: cell.student))/100
        cell.score.text = String(calculatePoint(student: cell.student))

        return cell
    }
    
    // MARK: - Helpers
    
    private func getAllStudents() {
        studentService.fetchStudents { [weak self] students in
            self!.students = students
            
            self!.students.sort { student1, student2 in
                let point1 = self!.calculatePoint(student: student1)
                let point2 = self!.calculatePoint(student: student2)
                return point2 < point1 
            }
            
            DispatchQueue.main.async {
                self!.scoreboard.tableView.reloadData()
            }
        }
    }
    
    func calculatePoint(student: Student) -> Int {
        var point: Int = 0
        var numberOfIsPresentTrue = 0
        
        let attendanceRecords = student.attendanceRecords
        let totalDay = attendanceRecords.count
        
        for attendanceRecord in attendanceRecords {
            
            if attendanceRecord.is_present {
                numberOfIsPresentTrue += 1
            }
        }
        if totalDay > 0 {
            point = (numberOfIsPresentTrue * 100) / totalDay
        } else {
            return 0
        }
        return point
    }
    
  
    
 

}


