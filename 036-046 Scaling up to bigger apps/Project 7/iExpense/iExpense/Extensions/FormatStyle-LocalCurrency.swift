//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Michael Brünen on 04.01.22.
//  Copyright © 2022 Michael Brünen. All rights reserved.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
