// CategoryRecipeViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана списка рецептов одной категории
protocol CategoryRecipeViewProtocol: AnyObject {
    /// Установка заголовка экрана
    func setTitle(title: String)
    /// Перезагрузить таблицу
    func reloadTable()
    /// Загрузить изображение в ячейку
    func loadImageInCell(indexCell: Int, imageBase64: String)
    /// Остановить обновление страницы
    func stopRefreshing()
}

/// Состояния загрузки
public enum ViewState<Model> {
    /// Данные еще не загружены
    case loading
    // Данные загружены
    case data(_ model: Model)
    /// Нет данных
    case noData(_ retryHandler: VoidHandler? = nil)
    /// Ошибка
    case error(_ error: Error, _ retryHandler: VoidHandler)
}

/// Протокол презентера экрана списка рецептов одной категории
protocol CategoryRecipeViewPresenterProtocol: AnyObject {
    /// Переход на экран рецептов по кнопке возврата
    func backToRecipeScreen()
    /// Переход на экран детализации рецепта
    func goToDetailRecipeScreen(index: Int)
    /// Изменить сортировку
    func changeSort(sortType: SortType, stateSort: SortButtonState)
    /// Начать поиск по рецептам
    func search(searchText: String)
    /// Загрузить данные
    func loadRecipes(refresh: Bool)
    //// Состояние загрузки
    var state: ViewState<[Recipe]> { get }
    ///  Записать переход на экран
    func logTransition()
    /// Загрузить изображение
    func loadImage(indexCell: Int)
}

/// Презентер экрана списка рецептов одной категории
final class CategoryRecipeViewPresenter: CategoryRecipeViewPresenterProtocol {
    // MARK: Constants

    private enum Constants {
        static let titleScreen = "Экран со списком рецептов"
        static let vegetarianText = "vegetarian"
        static let sideDishText = "Side dish"
    }

    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private let networkService: NetworkServiceProtocol?
    private weak var view: CategoryRecipeViewProtocol?
    private let proxyImageService: LoadImageServiceProtocol?
    private let storageSource = StorageService()
    private var recipes: [Recipe] = []
    private var presentedRecipes: [Recipe] = []
    private var category: Category?
    private var searchingActive = false
    private var searchText = ""
    private(set) var state: ViewState<[Recipe]> = .loading {
        didSet {
            view?.reloadTable()
        }
    }

    private var activatedSources: [SortType] = [
        .calories,
        .time
    ]
    private var activatedSourcesStates: [SortButtonState] = [
        .notSelected,
        .notSelected
    ]

    // MARK: Initializers

    init(
        view: CategoryRecipeViewProtocol?,
        coordinator: RecipesSceneCoordinator,
        networkService: NetworkServiceProtocol,
        category: Category
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.category = category
        proxyImageService = ProxyLoadService(service: LoadImageService())
        view?.setTitle(title: category.name)
    }

    // MARK: Public Methods

    func logTransition() {
        log(.goToScreen(screenName: Constants.titleScreen, title: category?.name ?? ""))
    }

    func loadRecipes(refresh: Bool = false) {
        state = .loading
        var categoryName = category?.name ?? ""
        var qParameter = ""
        var health = ""
        let replacingCategories = ["Chicken", "Meat", "Fish", "Side dish"]
        if replacingCategories.contains(categoryName) {
            categoryName = "Main course"
            qParameter = categoryName + searchText
            if categoryName == Constants.sideDishText {
                health = Constants.vegetarianText
            }
        }
        networkService?.getRecipes(
            categoryName: categoryName,
            qParameter: qParameter,
            health: health,
            completion: { [weak self] result in
                switch result {
                case let .success(recipes):
                    self?.recipes = recipes
                    self?.configureSort()
                    DispatchQueue.main.async {
//                            self?.state = .error(NetworkError.error(message: "Ошибка")) {}
                        self?.setupDataState()
                        if refresh {
                            self?.view?.stopRefreshing()
                        }
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        self?.state = .error(error) {}
                    }
                }
            }
        )
    }

    func loadImage(indexCell: Int) {
        guard recipes.indices.contains(indexCell) else { return }
        guard let url = URL(string: recipes[indexCell].imageUrl) else { return }
        proxyImageService?.loadImage(url: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            let base64Image = data.base64EncodedString()
            self.recipes[indexCell].imageBase64 = base64Image
            DispatchQueue.main.async {
                self.view?.loadImageInCell(indexCell: indexCell, imageBase64: base64Image)
            }
        }
    }

    func backToRecipeScreen() {
        coordinator?.backToPreviousScreen()
    }

    func goToDetailRecipeScreen(index: Int) {
        coordinator?.goToDetailRecipeScreen(uri: recipes[index].uri)
    }

    private func fillSources() {
        recipes = storageSource.getRecipes()
        category = recipes.last?.category
    }

    func search(searchText: String) {
        state = .loading
        if searchText.count > 3 {
            searchingActive = true
        } else {
            searchingActive = false
            self.searchText = ""
        }

        self.searchText = searchText
        setupDataState()
    }

    func changeSort(sortType: SortType, stateSort: SortButtonState) {
        state = .loading
        let firstSort = activatedSources.first
        let resetSort = firstSort == sortType

        if resetSort {
            activatedSources.remove(at: 0)
            activatedSourcesStates.remove(at: 0)

            activatedSources.append(sortType)
            activatedSourcesStates.append(stateSort)
        }

        guard let index = activatedSources.firstIndex(of: sortType) else { return }

        if activatedSources.contains(sortType) {
            activatedSourcesStates[index] = stateSort
        }

        configureSort()
        setupDataState()
    }

    // MARK: Private Methods

    private func setupDataState() {
        if searchingActive {
            state = .data(presentedRecipes.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            state = presentedRecipes.isEmpty ? .noData() : .data(presentedRecipes)
        }
    }

    private func configureSort() {
        let firstSort = activatedSources.first
        let stateFirstSort = activatedSourcesStates.first
        let secondSort = activatedSources.last
        let stateSecondSort = activatedSourcesStates.last

        if stateFirstSort == .notSelected, stateSecondSort == .notSelected {
            presentedRecipes = recipes
            return
        }

        presentedRecipes = recipes.sorted { lhs, rhs in
            switch ((firstSort, stateFirstSort), (secondSort, stateSecondSort)) {
            case ((.calories, .notSelected), (.time, .sortHighToLow)):
                return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes
            case ((.calories, .notSelected), (.time, .sortLowToHigh)):
                return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes

            case ((.calories, .sortHighToLow), (.time, .notSelected)):
                return lhs.caloriesCount > rhs.caloriesCount
            case ((.calories, .sortHighToLow), (.time, .sortHighToLow)):
                if lhs.caloriesCount == rhs.caloriesCount {
                    return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes
                }
                return lhs.caloriesCount > rhs.caloriesCount
            case ((.calories, .sortHighToLow), (.time, .sortLowToHigh)):
                if lhs.caloriesCount == rhs.caloriesCount {
                    return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes
                }
                return lhs.caloriesCount > rhs.caloriesCount
            case ((.calories, .sortLowToHigh), (.time, .notSelected)):
                return lhs.caloriesCount < rhs.caloriesCount

            case ((.calories, .sortLowToHigh), (.time, .sortHighToLow)):
                if lhs.caloriesCount == rhs.caloriesCount {
                    return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes
                }
                return lhs.caloriesCount < rhs.caloriesCount
            case ((.calories, .sortLowToHigh), (.time, .sortLowToHigh)):
                if lhs.caloriesCount == rhs.caloriesCount {
                    return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes
                }
                return lhs.caloriesCount < rhs.caloriesCount

            case ((.time, .notSelected), (.calories, .sortHighToLow)):
                return lhs.caloriesCount > rhs.caloriesCount
            case ((.time, .notSelected), (.calories, .sortLowToHigh)):
                return lhs.caloriesCount < rhs.caloriesCount

            case ((.time, .sortHighToLow), (.calories, .notSelected)):
                return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes

            case ((.time, .sortHighToLow), (.calories, .sortHighToLow)):
                if lhs.cookingTimeInMinutes == rhs.cookingTimeInMinutes {
                    return lhs.caloriesCount > rhs.caloriesCount
                }
                return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes
            case ((.time, .sortHighToLow), (.calories, .sortLowToHigh)):
                if lhs.cookingTimeInMinutes == rhs.cookingTimeInMinutes {
                    return lhs.caloriesCount < rhs.caloriesCount
                }
                return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes

            case ((.time, .sortLowToHigh), (.calories, .notSelected)):
                return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes

            case ((.time, .sortLowToHigh), (.calories, .sortHighToLow)):
                if lhs.cookingTimeInMinutes == rhs.cookingTimeInMinutes {
                    return lhs.caloriesCount > rhs.caloriesCount
                }
                return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes
            case ((.time, .sortLowToHigh), (.calories, .sortLowToHigh)):
                if lhs.cookingTimeInMinutes == rhs.cookingTimeInMinutes {
                    return lhs.caloriesCount < rhs.caloriesCount
                }
                return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes

            default: break
            }
            return false
        }
    }
}
