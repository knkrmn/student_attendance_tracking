import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String){
        self.init(frame: .zero)
        set(title : title)
}

    private func configureButton() {
        // Arka plan rengi
        backgroundColor = .systemBlue

        // Kenarlık ekleme
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor

        // Kenarları yuvarlatma
        layer.cornerRadius = 12

        // Buton gölgesi
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4

        // Metin ayarları
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        // İç ve dış dolgu ayarları
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    private func set(title: String) {
        setTitle(title, for: .normal)
    }
}
