
import UIKit

class DashCell: UITableViewCell {
    
    // MARK: - Properties
    
    let sequence: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let trophyImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium) // Daha büyük font
        label.textColor = UIColor.black
        return label
    }()
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = UIColor.blue // Progress bar rengini değiştirme
        progress.trackTintColor = UIColor.lightGray
        return progress
    }()
    
    let score: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.blue
        label.textAlignment = .center
        return label
    }()
    
    var student: Student! {
        didSet {
            //sequence.text = String(student.sequence) // Öğrenci sırası eklenebilir
            name.text = student.name
            //progressBar.progress = student.progress // Öğrenci ilerlemesi
            //score.text = "\(Int(student.progress * 100))" // Puanı yüzde olarak gösterebilirsiniz
        }
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(sequence)
        contentView.addSubview(name)
        contentView.addSubview(progressBar)
        contentView.addSubview(score)
        contentView.addSubview(trophyImageView)
        
        NSLayoutConstraint.activate([
            // Sequence label
            sequence.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            sequence.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Name label
            name.leadingAnchor.constraint(equalTo: sequence.trailingAnchor, constant: 8),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Progress bar
            //progressBar.leadingAnchor.constraint(equalTo: score.leadingAnchor, constant: -16),
            progressBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            progressBar.widthAnchor.constraint(equalToConstant: 100),  // Sabit genişlik
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            
            //trophyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200),
            trophyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trophyImageView.trailingAnchor.constraint(equalTo: progressBar.leadingAnchor, constant: -25),

            trophyImageView.widthAnchor.constraint(equalToConstant: 30),
            trophyImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Score label
            score.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            score.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Selection Style
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
     func setRanking(index: Int) {
        if index == 1 {
            //trophyImageView.image = UIImage(systemName: "trophy.fill")
            trophyImageView.image = UIImage(systemName: "trophy.fill")?.withRenderingMode(.alwaysTemplate)
            trophyImageView.tintColor = UIColor.systemYellow
        } else if index == 2 {
            //trophyImageView.image = UIImage(systemName: "medal.fill")
            trophyImageView.image = UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate)
            //trophyImageView.tintColor = UIColor.lightGray // Gümüş rengi
            trophyImageView.tintColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1) // Gümüş rengi
        } else if index == 3 {
            //trophyImageView.image = UIImage(systemName: "star.fill")
            trophyImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            trophyImageView.tintColor = UIColor(red: 205/255, green: 127/255, blue: 50/255, alpha: 1) // Bronz rengi
        } else {
            trophyImageView.image = nil
            sequence.text = "\(index)"
        }
    }
}


