import FirebaseFirestore

class StudentService {
    private let db = Firestore.firestore()
    
    func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        db.collection("students").getDocuments { (snapshot, error) in
            var students: [Student] = []
            
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion(students)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No document")
                completion(students)
                return
            }
            
            for document in documents {
                let data = document.data()
                let documentID = document.documentID
                
                if let studentID = data["studentID"] as? Int,
                   let name = data["name"] as? String,
                   let email = data["email"] as? String,
                   let parentMail = data["parentMail"] as? String,
                   let attendanceRecordsData = data["attendanceRecords"] as? [[String: Any]] {
                    
                    var attendanceRecords: [AttendanceRecord] = []
                    for recordData in attendanceRecordsData {
                        if let date = recordData["date"] as? String,
                           let is_present = recordData["is_present"] as? Bool {
                            let attendanceRecord = AttendanceRecord(date: date, is_present: is_present)
                            attendanceRecords.append(attendanceRecord)
                        }
                    }
                    
                    let student = Student(documentID: documentID, studentID: studentID, name: name, email: email, parentMail: parentMail, attendanceRecords: attendanceRecords)
                    students.append(student)
                } else {
                    print("Öğrenci bilgileri eksik veya yanlış formatta:", document.data())
                }
            }
            print("Student servise öğrenci sayısı \(students.count)")
            completion(students)
        }
    }
    
    
    func getAttendanceByDate(for date: String, student: Student, completion: @escaping (Bool?) -> Void) {
        
        let studentRef = db.collection("students").document(student.documentID)
        
        studentRef.getDocument { (document, error) in
            if let error = error {
                print("getAttendanceByDate - Öğrenci bilgileri alırken hata: \(error.localizedDescription)")
                completion(true)
                return
            }
            let attendanceRecords = document!.data()?["attendanceRecords"] as? [[String: Any]] ?? []
            if let index = attendanceRecords.firstIndex(where: { ($0["date"] as? String) == date }) {
                let isPresent = attendanceRecords[index]["is_present"] as? Bool
                completion(isPresent)
            } else {
                completion(true)
            }
        }
    }
    
    
    
    func saveAttendanceRecord(for student:Student, record : AttendanceRecord) {
        let studentRef = db.collection("students").document(student.documentID)
        
        studentRef.getDocument { (document,error) in
            
            if error != nil {
                print("saveAttendancerocord - Öğrenci belgesi alınırken hata ")
                return
            }
            
            
            var attendanceRecords = document!.data()?["attendanceRecords"] as? [[String: Any]] ?? []
            
            if let index = attendanceRecords.firstIndex(where: { ($0["date"] as? String) == record.date }) {
                attendanceRecords[index]["is_present"] = record.is_present
            }
            
            else {
                let newAttendanceRecord : [String : Any] = [
                    "date" : record.date,
                    "is_present" : record.is_present
                ]
                attendanceRecords.append(newAttendanceRecord)
            }
            
            studentRef.updateData(["attendanceRecords" : attendanceRecords]) { error in
                if error != nil {
                    print("saveAttendancerocord error",error?.localizedDescription as Any)
                } else {
                    print("Updated succesfully")
                }
            }
        }
    }
    
    func getStudentFromParentMail(parentMail: String, completion: @escaping (Student?) -> Void) {
        let db = Firestore.firestore()
        let studentsCollection = db.collection("students")
        
        studentsCollection.whereField("parentMail", isEqualTo: parentMail).getDocuments { (querySnapshot, error) in
            
            if let error = error {
                print("Error getting document: \(error)")
                completion(nil)
                return
            }
            
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No students found")
                completion(nil)
                return
            }
            
            if let document = documents.first {
                let data = document.data()
                let documentID = document.documentID
                
                let studentID = data["studentID"] as? Int ?? 0
                let name = data["name"] as? String ?? "Unknown"
                let parentMail = data["parentMail"] as? String ?? ""
                
                // Attendance records data parse
                if let attendanceArray = data["attendanceRecords"] as? [[String: Any]] {
                    do {
                        // JSON verisini Data tipine çevirip decode ediyoruz
                        let jsonData = try JSONSerialization.data(withJSONObject: attendanceArray, options: [])
                        let attendanceRecords = try JSONDecoder().decode([AttendanceRecord].self, from: jsonData)
                        
                        let student = Student(
                            documentID: documentID,
                            studentID: studentID,
                            name: name,
                            email: "", // Email alanı varsa doldurun
                            parentMail: parentMail,
                            attendanceRecords: attendanceRecords,
                            isChecked: true
                        )
                        
                        completion(student)
                    } catch {
                        print("Error decoding attendance records: \(error)")
                        completion(nil)
                    }
                } else {
                    print("No valid attendance records found")
                    completion(nil)
                }
            }
        }
    }

    

}

