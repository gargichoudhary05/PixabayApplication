
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImageViewModelDelegate {
    private var tableView = UITableView()
  private var viewModel = ImageViewModel()
//  private let viewModel: ImageViewModel
//
//  init(viewModel: ImageViewModel) {
//          self.viewModel = viewModel
//          super.init(nibName: nil, bundle: nil)
//      }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    private var topActivityIndicatorView = UIActivityIndicatorView()
    private var bottomActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicatorViews()
        viewModel.delegate = self
        viewModel.loadImages()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupActivityIndicatorViews() {
        topActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        topActivityIndicatorView.center = CGPoint(x: view.bounds.width / 2, y: 50)
        view.addSubview(topActivityIndicatorView)

        bottomActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        bottomActivityIndicatorView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 50)
        bottomActivityIndicatorView.hidesWhenStopped = true
        view.addSubview(bottomActivityIndicatorView)
    }

    private func updateActivityIndicators() {
        topActivityIndicatorView.startAnimating()
    }

    func imageDataUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateActivityIndicators()
            self.bottomActivityIndicatorView.stopAnimating()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell

        let image = viewModel.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.loadMoreImages()
            bottomActivityIndicatorView.startAnimating()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
