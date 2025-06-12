//
//  InfoPagesViewControllers.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-09-04.
//

import UIKit

class ContactUsViewController: UIViewController {
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        For any inquiries, feedback, or support, please feel free to contact us at:
        Email: support@demo.com
        Phone: +1 234 567 8900
        We are here to help you 24/7!
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1) // Light background color
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.1
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.shadowRadius = 3
        return textView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerLabel)
        view.addSubview(contentTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let headerHeight: CGFloat = 60
        headerLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: view.bounds.width - 40, height: headerHeight)
        contentTextView.frame = view.bounds.insetBy(dx: 20, dy: headerHeight + 40)
    }
}

// Repeat similar enhancements for AboutUsViewController and VisionViewController

class AboutUsViewController: UIViewController {
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Welcome to our app! We are a dedicated team of developers passionate about providing the best streaming experience for our users. Our vision is to create a platform where everyone can enjoy their favorite movies and TV shows with ease. Stay tuned for more exciting features!
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.1
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.shadowRadius = 3
        return textView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "About Us"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerLabel)
        view.addSubview(contentTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let headerHeight: CGFloat = 60
        headerLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: view.bounds.width - 40, height: headerHeight)
        contentTextView.frame = view.bounds.insetBy(dx: 20, dy: headerHeight + 40)
    }
}

class VisionViewController: UIViewController {
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Our vision is to build a platform that transforms the way people watch movies and TV shows. We aim to bring the latest and greatest content to your fingertips, ensuring a seamless and enjoyable viewing experience for all users.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.1
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.shadowRadius = 3
        return textView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Vision"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.backgroundColor = .systemOrange
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerLabel)
        view.addSubview(contentTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let headerHeight: CGFloat = 60
        headerLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: view.bounds.width - 40, height: headerHeight)
        contentTextView.frame = view.bounds.insetBy(dx: 20, dy: headerHeight + 40)
    }
}
