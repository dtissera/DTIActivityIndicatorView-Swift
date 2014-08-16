//
//  DTIAnim.swift
//  SampleApplication
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

import UIKit

protocol DTIAnimProtocol {
    func needUpdateColor()
    func needLayoutSubviews()
    func setUp()

    func startActivity()
    func stopActivity(animated: Bool)
}