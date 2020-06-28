//
//  User.swift
//  FriendFace
//
//  Created by Michael Brünen on 28.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

// Example data
/*
 id         "50a48fa3-2c0f-4397-ac50-64da464f9954"
 isActive   false
 name       "Alford Rodriguez"
 age        21
 company    "Imkan"
 email      "alfordrodriguez@imkan.com"
 address    "907 Nelson Street, Cotopaxi, South Dakota, 5913"
 about      "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n"
 registered "2015-11-10T01:47:18-00:00"
 tags
    0       "cillum"
    1       "consequat"
    2       "deserunt"
    3       "nostrud"
    4       "eiusmod"
    5       "minim"
    6       "tempor"
 friends
    0
        id      "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0"
        name    "Hawkins Patel"
    1    {…}
    2    {…}
    3    {…}
    4    {…}
    5    {…}
    6    {…}
    7    {…}
    8    {…}
    9    {…}
    10    {…}
 */
