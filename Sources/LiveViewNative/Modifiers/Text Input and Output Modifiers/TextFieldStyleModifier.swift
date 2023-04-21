//
//  TextFieldStyleModifier.swift
//  LiveViewNative
//
//  Created by Carson Katri on 4/6/2023.
//

import SwiftUI

/// Sets the style for ``TextField`` child elements.
///
/// Any child ``TextField`` will be given the specified ``style``.
///
/// ```html
/// <VStack modifiers={text_field_style(@native, style: :plain)}>
///     <TextField value-binding="email">Email</TextField>
///     <TextField value-binding="password">Password</TextField>
/// </VStack>
/// ```
///
/// See ``TextFieldStyle`` for a list of possible styles.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
struct TextFieldStyleModifier: ViewModifier, Decodable {
    /// The style to apply.
    ///
    /// See ``TextFieldStyle`` for a list of possible styles.
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    private let style: TextFieldStyle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.style = try container.decode(TextFieldStyle.self, forKey: .style)
    }

    func body(content: Content) -> some View {
        switch style {
        case .automatic:
            content.textFieldStyle(.automatic)
        case .plain:
            content.textFieldStyle(.plain)
        case .roundedBorder:
            #if !os(watchOS)
            content.textFieldStyle(.roundedBorder)
            #endif
        case .squareBorder:
            #if os(macOS)
            content.textFieldStyle(.squareBorder)
            #endif
        }
    }

    enum CodingKeys: String, CodingKey {
        case style
    }
}

#if swift(>=5.8)
@_documentation(visibility: public)
#endif
private enum TextFieldStyle: String, Decodable {
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    case automatic
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    case plain
    /// `rounded_border`
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    @available(iOS 16.0, tvOS 16.0, macOS 13.0, *)
    case roundedBorder = "rounded_border"
    /// `square_border`
    #if swift(>=5.8)
    @_documentation(visibility: public)
    #endif
    @available(macOS 13.0, *)
    case squareBorder = "square_border"
}