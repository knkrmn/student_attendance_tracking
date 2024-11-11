import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    convenience init(isSecureText:Bool,placeHolder:String){
        self.init(frame: .zero)
        set(isSecureText: isSecureText,placeHolder: placeHolder)
}
    func configure() {
        
        // Kenarlık ve yuvarlak köşeler
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10.0
        
        // İçerik rengi ve yazı tipi
        self.textColor = UIColor.darkGray
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 24, weight: .medium)

        
        // Sol boşluk ekleme
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        // Gölge efekti
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        // Arka plan rengi
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
}
    private func set(isSecureText : Bool, placeHolder: String){
        isSecureTextEntry   = isSecureText
        // Placeholder rengi
        let placeholderText = NSAttributedString(string: placeHolder,
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.attributedPlaceholder = placeholderText
} }
