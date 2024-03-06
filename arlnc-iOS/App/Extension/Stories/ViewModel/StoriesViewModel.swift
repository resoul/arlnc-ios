//
//  StoriesViewModel.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

struct StoriesViewModel {
    let user: User
    let isMe: Bool
    var isLive: Bool
    var lastViewedIndex: Int
    let stories: [Story]
}
