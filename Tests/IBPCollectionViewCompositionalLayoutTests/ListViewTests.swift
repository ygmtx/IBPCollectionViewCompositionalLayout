import XCTest
import IBPCollectionViewCompositionalLayout

class ListViewTests: XCTestCase {
    func testViewController() {
        let viewController = ListViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0))

        let collectionView = viewController.collectionView!
        let height: CGFloat = 44
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        if #available(iOS 11.0, *) {
            let safeAreaInsets = viewController.view.safeAreaInsets

            XCTAssertEqual(collectionView.adjustedContentInset, safeAreaInsets)
            XCTAssertEqual(collectionView.contentOffset, CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top))
            XCTAssertEqual(collectionView.contentSize, CGSize(width: window.bounds.width, height: height * CGFloat(numberOfItems)))

            for case (let index, let cell as UICollectionViewCell) in collectionView.subviews.enumerated() {
                XCTAssertEqual(cell.frame, CGRect(x: 0, y: CGFloat(index) * height, width: window.bounds.width, height: height))
            }
        } else {

        }
    }

    func testNavigationController() {
        let viewController = ListViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0))

        let collectionView = viewController.collectionView!
        let height: CGFloat = 44
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        if #available(iOS 11.0, *) {
            let safeAreaInsets = viewController.view.safeAreaInsets

            XCTAssertEqual(collectionView.adjustedContentInset, safeAreaInsets)
            XCTAssertEqual(collectionView.contentOffset, CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top))
            XCTAssertEqual(collectionView.contentSize, CGSize(width: window.bounds.width, height: height * CGFloat(numberOfItems)))

            for case (let index, let cell as UICollectionViewCell) in collectionView.subviews.enumerated() {
                XCTAssertEqual(cell.frame, CGRect(x: 0, y: CGFloat(index) * height, width: window.bounds.width, height: height))
            }
        } else {

        }
    }

    func testTabBarController() {
        let viewController = ListViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [viewController]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0))

        let collectionView = viewController.collectionView!
        let height: CGFloat = 44
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        if #available(iOS 11.0, *) {
            let safeAreaInsets = viewController.view.safeAreaInsets

            XCTAssertEqual(collectionView.adjustedContentInset, safeAreaInsets)
            XCTAssertEqual(collectionView.contentOffset, CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top))
            XCTAssertEqual(collectionView.contentSize, CGSize(width: window.bounds.width, height: height * CGFloat(numberOfItems)))

            for case (let index, let cell as UICollectionViewCell) in collectionView.subviews.enumerated() {
                XCTAssertEqual(cell.frame, CGRect(x: 0, y: CGFloat(index) * height, width: window.bounds.width, height: height))
            }
        } else {

        }
    }

    func testNavigationControllerInTabBarController() {
        let viewController = ListViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: viewController)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0))

        let collectionView = viewController.collectionView!
        let height: CGFloat = 44
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        if #available(iOS 11.0, *) {
            let safeAreaInsets = viewController.view.safeAreaInsets

            XCTAssertEqual(collectionView.adjustedContentInset, safeAreaInsets)
            XCTAssertEqual(collectionView.contentOffset, CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top))
            XCTAssertEqual(collectionView.contentSize, CGSize(width: window.bounds.width, height: height * CGFloat(numberOfItems)))

            for case (let index, let cell as UICollectionViewCell) in collectionView.subviews.enumerated() {
                XCTAssertEqual(cell.frame, CGRect(x: 0, y: CGFloat(index) * height, width: window.bounds.width, height: height))
            }
        } else {

        }
    }
}

class ListViewController: UIViewController {
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List"
        configureHierarchy()
        configureDataSource()
    }
}

extension ListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ListViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        view.addSubview(collectionView)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { (collectionView, indexPath, identifier) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}