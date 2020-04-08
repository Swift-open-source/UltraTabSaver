//
//  SafariExtensionHandler.swift
//  TabSaver Extension
//
//  Created by Matias Morsa on 28/03/2020.
//  Copyright © 2020 Matias Morsa. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    var safari = SafariExtensionViewController.shared

    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        Persistance.shared.setThis(page: page)
        
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // Este metodo no hace nada
        SafariExtensionViewController.shared.toolbarItemClicked(sender: window)
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        SafariExtensionViewController.shared.flag(bool: true)
        return  safari
    }
    

    func applicationWillTerminate(){
        
    }
    
    override func contextMenuItemSelected(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil) {
        if (command.elementsEqual("Save All tabs")){
            SafariExtensionViewController.shared.saveAll(sender: SFSafariPage.self)
        } else if (command.elementsEqual("Get All tabs")){
            SafariExtensionViewController.shared.getAll(sender: SFSafariPage.self)
            } else {
            SafariExtensionViewController.shared.saveThis(sender: SFSafariPage.self)
            SafariExtensionViewController.shared.getAll(sender: SFSafariPage.self)
        }
    }
}
    
