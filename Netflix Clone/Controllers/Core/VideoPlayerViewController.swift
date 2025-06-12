import UIKit
import WebKit

class VideoPlayerViewController: UIViewController {
    private var webView: WKWebView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var watchLaterButton: UIButton!

    var videoId: String?
    var videoTitle: String?
    var videoDescription: String?
    var publishedAt: String?


    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupWebView()
        setupTitleLabel()
        setupDateLabel()
        setupDescriptionLabel()
        setupWatchLaterButton()

        if let videoId = videoId {
            playVideo(videoId: videoId)
        }
        titleLabel.text = videoTitle ?? "No Title"
        descriptionLabel.text = videoDescription ?? "No description available"
        
        if let publishedDate = publishedAt {
                dateLabel.text = formattedDate(from: publishedDate)
            } else {
                dateLabel.text = "📅 Published date not available"
            }
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(webView)
        webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(titleLabel)
    }

    
//    private func setupDateLabel() {
//        let horizontalStack = UIStackView()
//        horizontalStack.axis = .horizontal
//        horizontalStack.distribution = .equalSpacing
//        horizontalStack.alignment = .center
//        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
//
//        let videoLabel = UILabel()
//        videoLabel.text = "🎬 Video"
//        videoLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        videoLabel.textColor = .systemBlue
//
//        dateLabel = UILabel()
//        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        dateLabel.textColor = .darkGray
//        dateLabel.textAlignment = .right
//
//        horizontalStack.addArrangedSubview(videoLabel)
//        horizontalStack.addArrangedSubview(dateLabel)
//
//        contentStackView.addArrangedSubview(horizontalStack)
//    }

    private func setupDateLabel() {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .equalSpacing
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        let videoLabel = UILabel()
        
        // Use SF Symbol with text
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "video")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)

        let attributedText = NSMutableAttributedString(attachment: attachment)
        attributedText.append(NSAttributedString(string: "  Video", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.orange
        ]))
        videoLabel.attributedText = attributedText

        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .right

        horizontalStack.addArrangedSubview(videoLabel)
        horizontalStack.addArrangedSubview(dateLabel)

        contentStackView.addArrangedSubview(horizontalStack)
    }

    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .justified
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(descriptionLabel)
    }

    private func setupWatchLaterButton() {
        watchLaterButton = UIButton(type: .system)
        watchLaterButton.setTitle("➕ Watch Later", for: .normal)
        watchLaterButton.setTitleColor(.white, for: .normal)
        watchLaterButton.backgroundColor = UIColor.black
        watchLaterButton.layer.cornerRadius = 12
        watchLaterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        watchLaterButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        watchLaterButton.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(watchLaterButton)
    }

    private func playVideo(videoId: String) {
        let urlString = "https://www.youtube.com/embed/\(videoId)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    private func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return isoDate
    }

}
