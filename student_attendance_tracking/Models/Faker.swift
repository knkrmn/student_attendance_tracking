import FirebaseFirestore
import Fakery

func uploadFakeData() {
    let db = Firestore.firestore()
    
    // Faker kütüphanesini kullanarak sahte veri oluşturma
    let faker = Faker()
    
    for _ in 1...15 { // 10 öğrenci verisi yükle
        let studentData: [String: Any] = [
            "name": faker.name.name(),
            "email": faker.internet.email(),
            "studentID": faker.number.randomInt(),
            "parentMail": faker.internet.email(),
            "attendanceRecords":[]
        ]
        
        // Firestore'da "students" koleksiyonuna veri ekleme
        db.collection("students").addDocument(data: studentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Student data added successfully")
            }
        }
    }
}
