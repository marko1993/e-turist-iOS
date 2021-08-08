//
//  CommentsViewModel.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

class CommentsViewModel: BaseViewModel {
    var destinationId: Int?
    var routeId: Int!
    private var currentPage: Int = 0
    var allCommentsFetched: Bool = false
    private var comments: [Comment] = []
    
    let commentsRelay: BehaviorRelay<[Comment]> = BehaviorRelay(value: [])
    var commentsObservable: Observable<[Comment]> {
        return commentsRelay.asObservable()
    }
    
    func getCommentCount() -> Int {
        return comments.count
    }

    func fetchComments(limit: Int = 12) {
        self.currentPage += 1
        self.repository?.getComments(routeId: routeId, destinationId: destinationId, limit: limit, page: self.currentPage, completion: { [weak self] response, errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error, responseCode: response?.status)
            }
            if let responseModel = response?.data {
                self?.comments.append(contentsOf: responseModel.comments)
                self?.commentsRelay.accept(self?.comments ?? [])
                
                if responseModel.comments.isEmpty {
                    self?.allCommentsFetched = true
                }
            }
        })
    }
    
    func addComment(comment: String) {
        if let destinationId = self.destinationId {
            self.repository?.postCommentToDestination(routeId: routeId, destinationId: destinationId, comment: comment, completion: { [weak self] response, errorMessage in
                if let error = errorMessage {
                    self?.handleNetworkError(error: error, responseCode: response?.status)
                }
                if let responseModel = response?.data {
                    self?.appendComment(comment: responseModel.comment)
                }
            })
        } else {
            self.repository?.postCommentToRoute(routeId: routeId, comment: comment, completion: { [weak self] response, errorMessage in
                if let error = errorMessage {
                    self?.handleNetworkError(error: error, responseCode: response?.status)
                }
                if let responseModel = response?.data {
                    self?.appendComment(comment: responseModel.comment)
                }
            })
        }
    }
    
    private func appendComment(comment: Comment) {
        self.comments.insert(comment, at: 0)
        self.commentsRelay.accept(self.comments)
    }
    
}
