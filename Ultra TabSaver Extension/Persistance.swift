//
//  window.swift
//  TabSaver Extension
//
//  Created by Matias Morsa on 28/03/2020.
//  Copyright © 2020 Matias Morsa. All rights reserved.
//

import Foundation
import SafariServices

struct Page : Codable, Equatable {
    var title: String
    var url: URL
    init() {
        self.title = "ERROR"
        self.url = URL(string:"https://www.google.com")!
    }
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
}

class Persistance {
    
    
    var actual_page:SFSafariPage!
    static let shared = Persistance()
    var date = Date()
    let date_formatter = DateFormatter()
    var current_pageWindow:SFSafariWindow!
    var emptyDict = [String:[Page]]()
    
    init(){
        load()
        UserDefaults.standard.synchronize()
        date_formatter.dateFormat = "dd.MM.yyyy"
    }
    
    
    func setActualPage(page: SFSafariPage){
        self.actual_page = page
    }
    
    func getDictionaryAsString() -> [String:[Page]]{
        var dic2:[String:[Page]] = [:]
        for (k,_) in emptyDict{
            dic2[k] = emptyDict[k]
        }
        return dic2
    }
    
    func getURLlist(lista:[URL]) -> [String]{
        var lista2:[String] = []
        for url in  lista{
            lista2.append(url.absoluteString)
        }
        return lista2
    }
    
    func getStringAsDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
    func saveActualPage(){
        if (actual_page != nil){
            actual_page.getPropertiesWithCompletionHandler({ (properties) in
                guard let properties = properties else {
                    self.validationHandler(false, "")
                    return
                }
                
                guard let url = properties.url else {
                    self.validationHandler(false, "")
                    return
                }
                guard url.scheme == "http" || url.scheme == "https" else {
                    self.validationHandler(false, "")
                    return
                }
                guard let title = properties.title else {
                    self.validationHandler(false, "")
                    return
                }
                let page = Page(title: String(title.prefix(15)), url: url)
                self.emptyDict[self.getStringAsDate(date: Date())] = [page]
            })
        }
        persist()
        if(actual_page != nil ){
            actual_page!.getContainingTab(completionHandler: { currentTab in
                currentTab.getContainingWindow(completionHandler: { window in
                    self.current_pageWindow  = window
                    window?.getAllTabs(completionHandler: { tab_list in
                        for _ in tab_list{
                            NSWorkspace.shared.open(URL(string:"https://www.google.com")!)
                            if (tab_list.count > 1){
                                currentTab.close()
                            }else{
                                NSWorkspace.shared.open(URL(string:"https://www.google.com")!)
                                currentTab.close()
                                return
                            }
                            
                        }
                    })
                })
            })
        }
    }
    
    
    func getUrlByKey(key:String) -> [Page] {
        var retorno = [Page()]
        for (k,_) in emptyDict{
            if (k.elementsEqual(key)){
                retorno =  emptyDict[k]!
            }
        }
        return retorno
    }
    
    func saveAllPages(){
        var flag = true
        let date = getStringAsDate(date:Date())
        if(actual_page != nil ){
            actual_page!.getContainingTab(completionHandler: { currentTab in
                currentTab.getContainingWindow(completionHandler: { window in
                    self.current_pageWindow  = window
                    window?.getAllTabs(completionHandler: { tab_list in
                        var i = 0
                        for tab in tab_list{
                            tab.getActivePage(completionHandler: { (page) in
                                guard let page = page else{
                                    self.validationHandler(false, "")
                                    return
                                }
                                page.getPropertiesWithCompletionHandler({ (properties) in
                                    guard let properties = properties else {
                                        self.validationHandler(false, "")
                                        return
                                    }
                                    
                                    guard let url = properties.url else {
                                        self.validationHandler(false, "")
                                        return
                                    }
                                    guard url.scheme == "http" || url.scheme == "https" else {
                                        self.validationHandler(false, "")
                                        return
                                    }
                                    guard let title = properties.title else {
                                        self.validationHandler(false, "")
                                        return
                                    }
                                    let page = Page(title: title, url: url)
                                    if flag{
                                        self.emptyDict[date] = [page]
                                        flag = false
                                    }else{
                                        self.emptyDict[date]?.append(page)
                                    }
                                    self.persist()
                                })
                                NSWorkspace.shared.open(URL(string:"https://www.google.com")!)
                                if (i < tab_list.count){
                                    tab.close()
                                    i += 1
                                }
                            })
                        }
                    })
                })
            })
        }
    }
    
    func validationHandler(_: Bool,_: String){
        
    }
    
    func getSelected(date:Date){
        
    }
    
    func deleteAll(){
        emptyDict = [:]
        persist()
    }
    
    func getAll()-> [String:[Page]] {
        load()
        return self.emptyDict
    }
    
    func persist(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        let dic2:[String:[Page]] = getDictionaryAsString()
        var  keyList = [String]()
        for (key,value) in dic2{
            do {
                
                let data = try JSONEncoder().encode(value)
                UserDefaults.standard.setValue(data, forKey: key)
                keyList.append(key)
                
            }
            catch {
                
                print(error)
            }
        }
        //     let myData = NSKeyedArchiver.archivedData(withRootObject: keys)
        UserDefaults.standard.set(keyList, forKey: "UTSkeysPages")
        
        UserDefaults.standard.synchronize()
    }
    
    
    func load(){
        UserDefaults.standard.synchronize()
        let keys:[String] =  UserDefaults.standard.object(forKey: "UTSkeysPages") as? [String] ?? []
        UserDefaults.standard.synchronize()
        if(!keys.isEmpty){
            for key in keys
            {
                do {
                    let storedData = UserDefaults.standard.data(forKey: key)
                    var pages = try JSONDecoder().decode([Page].self, from: storedData!)
                    emptyDict[key] = getURLFromString(pages: pages)
                }
                catch {
                    
                    print(error)
                }
                
            }
        }
    }
    
    func deleteKey(key: String){
        emptyDict.removeValue(forKey: key)
        persist()
    }
    
    func renameKey(oldKey:String, newKey:String){
        if(emptyDict.keys.contains(newKey)){
            dialogOK(question: "This name already exist", text: "Try another value")
        }else{
            emptyDict[newKey] = emptyDict[oldKey]
            deleteKey(key: oldKey)
            persist()
        }
    }
    
    func addPage(key:String, page:Page){
        emptyDict[key]?.append(page)
        persist()
    }
    
    func dialogOK(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        return alert.runModal() == .alertFirstButtonReturn
        
    }
    
    func deletePage(key:String, page:Page ){
        let index = emptyDict[key]?.firstIndex(of: page) ?? -1
        if (index != -1){
            emptyDict[key]?.remove(at: index)
        }
        persist()
    }
    
    
    func getURLFromString(pages:[Page]) -> [Page]  {
        var list:[Page] = []
        for page in  pages{
            list.append(page)
        }
        return list
    }
    
    func getWindow()->SFSafariWindow{
        return self.current_pageWindow
    }
    
    func setWindow(window:SFSafariWindow){
        self.current_pageWindow = window
    }
}
