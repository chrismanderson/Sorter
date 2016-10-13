//
//  SourceEditorCommand.swift
//  SorterExtension
//
//  Created by Chris Anderson on 10/13/16.
//  Copyright © 2016 Chris Anderson. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            completionHandler(NSError(domain: "Sorter", code: -1, userInfo: [NSLocalizedDescriptionKey: "No selection"]))
            return
        }
        
        let selectionRange = selection.start.line...selection.end.line
        let sorted = selectionRange.map({ invocation.buffer.lines[$0] as! String }).sorted { $0 < $1 }
        
        invocation.buffer.lines.replaceObjects(at: IndexSet(integersIn: selectionRange), with: sorted)
        
        completionHandler(nil)
    }
}
