//
//  WaitingChatsNavigation.swift
//  IChat
//
//  Created by Михаил Красильник on 26.04.2021.
//

import Foundation

protocol WaitingChatsNavigation {
    func rmoveWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
