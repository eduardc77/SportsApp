//
//  CoachesViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class CoachesViewModel: BaseViewModel<ViewState> {
    private let service: CoachesServiceable
    
    private(set) var responseModel: CoachesResponseModel?
    private(set) var data = [Coach]()
    
    var currentPage: Int {
        (responseModel?.pagination?.currentPage ?? 0) + 1
    }
    
    var hasMoreContent: Bool {
        responseModel?.pagination?.hasMore ?? false
    }

    init(data: [Coach] = [], service: CoachesServiceable = CoachesService()) {
        self.data = data
        self.service = service
    }

    @MainActor
    func fetchAllData(page: Int? = nil) async {
        guard state != .empty else { return }
        
        do {
            let result: CoachesResponseModel = try await service.getAllCoaches(currentPage: page ?? currentPage)
            
            if currentPage == 1 || data.isEmpty {
                self.changeState(.loading)
            }
            if page == 1 {
                data = result.data
            } else {
                updateData(with: result)
            }
            responseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard responseModel?.pagination?.nextPage != nil, hasMoreContent else { return }
        await fetchAllData()
    }
    
    func refresh() async {
        await fetchAllData(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateData(with result: CoachesResponseModel) {
        data += result.data
    }
}
