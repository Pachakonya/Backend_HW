//
//  Post.swift
//  backendtest
//
//  Created by Dastan Sugirbay on 11.06.2025.
//
import Foundation

struct Post: Codable, Identifiable {
    let id: Int?
    let title: String
    let content: String
}
