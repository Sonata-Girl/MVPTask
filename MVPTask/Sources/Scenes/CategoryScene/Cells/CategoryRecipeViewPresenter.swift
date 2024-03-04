// CategoryRecipeViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол вью экрана списка рецептов одной категории
protocol CategoryRecipeViewProtocol: AnyObject {
    /// Установка заголовка экрана
    func setTitle(title: String)
    /// Перезагрузить таблицу
    func reloadTable()
}

/// Протокол презентера экрана списка рецептов одной категории
protocol CategoryRecipeViewPresenterProtocol: AnyObject {
    /// Переход на экран рецептов по кнопке возврата
    func backToRecipeScreen()
    /// Получение рецептов для таблицы
    func getRecipes() -> [Recipe]
    /// Переход на экран детализации рецепта
    func goToDetailRecipeScreen(index: Int)
    /// Изменить сортировку
    func changeSort(sortType: SortType, stateSort: SortButtonState)
    /// Начать поиск по рецептам
    func search(active: Bool, searchText: String)
}

/// Презентер экрана списка рецептов одной категории
final class CategoryRecipeViewPresenter: CategoryRecipeViewPresenterProtocol {
    // MARK: Public Properties

    private weak var coordinator: RecipesSceneCoordinator?

    // MARK: Private Properties

    private weak var view: CategoryRecipeViewProtocol?
    private let storageSource = StorageService()
    private var recipes: [Recipe]?
    private var presentedRecipes: [Recipe]?
    private var category: Category?
    private var searchingActive = false
    private var searchText = ""
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
        coordinator: RecipesSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        fillSources()
        configureSort()
        view?.setTitle(title: category?.name ?? "")
    }

    func getRecipes() -> [Recipe] {
        if searchingActive {
            return presentedRecipes?.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            } ?? []
        }
        return presentedRecipes ?? []
    }

    func backToRecipeScreen() {
        coordinator?.backToPreviousScreen()
    }

    func goToDetailRecipeScreen(index: Int) {
        guard let recipes else { return }
        coordinator?.goToDetailRecipeScreen(recipe: recipes[index])
    }

    private func fillSources() {
        recipes = storageSource.getRecipes()
        category = recipes?.last?.category
    }

    func search(active: Bool, searchText: String) {
        searchingActive = active
        self.searchText = searchText
        view?.reloadTable()
    }

    func changeSort(sortType: SortType, stateSort: SortButtonState) {
        if activatedSources.contains(sortType) {
            guard let index = activatedSources.firstIndex(of: sortType) else { return }
            activatedSources.remove(at: index)
            activatedSourcesStates.remove(at: index)
        }

        activatedSources.append(sortType)
        activatedSourcesStates.append(stateSort)

        configureSort()
        view?.reloadTable()
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

        presentedRecipes = recipes?.sorted { lhs, rhs in
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
                return lhs.caloriesCount > rhs.caloriesCount

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
                return lhs.cookingTimeInMinutes < rhs.cookingTimeInMinutes
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
                return lhs.cookingTimeInMinutes > rhs.cookingTimeInMinutes

            default: break
            }
            return false
        }
    }
}
