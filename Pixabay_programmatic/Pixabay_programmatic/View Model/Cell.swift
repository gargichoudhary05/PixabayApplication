import UIKit
import SDWebImage

class Cell: UITableViewCell {
  private var photoImageView = UIImageView()
  private var idLabel = UILabel()
  private var tagsLabel = UILabel()
  private var userIconImage = UIImageView()
  private var userLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupImageView() {
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(photoImageView)
    
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      photoImageView.heightAnchor.constraint(equalToConstant: 180)
    ])
    
    idLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(idLabel)
    
    NSLayoutConstraint.activate([
      idLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
      idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
    tagsLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(tagsLabel)
    
    NSLayoutConstraint.activate([
      tagsLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
      tagsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      tagsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])
    userIconImage.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(userIconImage)
    
    NSLayoutConstraint.activate([
      userIconImage.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 8),
      userIconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      userIconImage.widthAnchor.constraint(equalToConstant: 30),
      userIconImage.heightAnchor.constraint(equalToConstant: 30)
    ])
    
    userLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(userLabel)
    
    NSLayoutConstraint.activate([
      userLabel.centerYAnchor.constraint(equalTo: userIconImage.centerYAnchor),
      userLabel.leadingAnchor.constraint(equalTo: userIconImage.trailingAnchor, constant: 8)
    ])
    userIconImage.contentMode = .scaleAspectFit
    
  }
  
  func configure(with image: ImageData) {
    if let url = URL(string: image.largeImageURL) {
      photoImageView.sd_setImage(with: url)
    }
    
    idLabel.text = "Image ID: \(image.id)"
    idLabel.textColor = UIColor.black
    idLabel.font = UIFont.systemFont(ofSize: 15)
    
    tagsLabel.text = "Tags: \(image.tags)"
    tagsLabel.textColor = UIColor.black
    tagsLabel.font = UIFont.systemFont(ofSize: 15)
    
    if let url = URL(string: image.userImageURL) {
      userIconImage.sd_setImage(with: url)
    }
    userLabel.text = "User: \(image.user)"
    userLabel.textColor = UIColor.black
    userLabel.font = UIFont.systemFont(ofSize: 15)
    
  }
}


