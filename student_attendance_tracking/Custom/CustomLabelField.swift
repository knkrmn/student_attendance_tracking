//
//  CustomLabelField.swift
//  InstaClonewithFireBase
//
//  Created by Okan Karaman on 18.10.2024.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Konforlu init metodu
    convenience init(text: String) {
        self.init(frame: .zero)
        set(text: text)
    }
    
    // UILabel'in tasarımını ayarlayan fonksiyon
    private func configure() {
        // Otomatik yerleşim için gerekli
        translatesAutoresizingMaskIntoConstraints = false
        
        // Yazı tipi, boyutu 30 olarak ayarlandı
        font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        // Metin rengi
        textColor = UIColor.lightGray
        
        // Arka plan rengi
        backgroundColor = UIColor.systemGray5
        
        // Kenarlık ve köşe yuvarlama
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        // Gölge ekleme
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 2, height: 4)
        
        // Metni ortalama
        textAlignment = .center
    }
    
    // Metni ayarlayan fonksiyon
    private func set(text: String?) {
        self.text = text ?? "Default Text"
    }
}
