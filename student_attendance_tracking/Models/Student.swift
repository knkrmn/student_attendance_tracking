import Foundation

// Devamsızlık durumu için bir yapı oluştur
struct AttendanceRecord: Decodable, Encodable {
    let date: String // Devamsızlık tarihi
    let is_present: Bool // Devamsızlık durumu
}

struct Student: Decodable, Encodable {
    let documentID: String // Firestore belgesinin kimliği
    let studentID: Int
    let name: String
    let email: String
    let parentMail: String
    var attendanceRecords: [AttendanceRecord]
    var isChecked: Bool = true
}

