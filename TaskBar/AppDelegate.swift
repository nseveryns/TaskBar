//
//  AppDelegate.swift
//  TaskBar
//
//  Created by Nathan Severyns on 9/5/18.
//  Copyright © 2018 Nathan Severyns. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var taskMenu: NSMenu!
    @IBOutlet weak var managerWindow: NSWindow!
    
    // Variables defined from the window that I need to retrieve values from
    // TODO: Change this into some sort of manager class to handle this
    // TODO: Even more ideal, only load the window when I need to add a task
    
    @IBOutlet weak var taskTitleField: NSTextField!
    @IBOutlet weak var taskPriorityField: NSLevelIndicatorCell!
    @IBOutlet weak var taskLinkField: NSTextField!
    @IBOutlet weak var taskDateField: NSDatePicker!
    
    var array = [Task]() // TODO: Replace this with an ordered list based on priority
   
    @IBOutlet weak var viewWindow: NSWindow!
    @IBOutlet weak var viewTitleField: NSTextField!
    @IBOutlet weak var viewColorField: NSColorWell!
    
    @IBAction func viewButtonClick(_ sender: NSButton) {
        viewWindow.setIsVisible(false)
    }
    
    @IBAction func viewNextButtonClick(_ sender: NSButton) {
        if (array.count > 0) {
            array.remove(at: 0)
        }
        viewItem(sender)
    }
    
    let taskItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    @IBAction func quitAction(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        taskItem.title = "Tasks"
        taskItem.menu = taskMenu
    }
    
    @IBAction func addItem(_ sender: Any) {
        managerWindow.setIsVisible(true)
    }
    
    @IBAction func viewItem(_ sender: NSButton) {
        viewWindow.setIsVisible(true)
        let task = array.first
        if (task != nil) {
            viewTitleField.stringValue = (task?.name)!
            return
        }
        viewTitleField.stringValue = "No task available."
    }
    
    @IBAction func submitTask(_ sender: Any) {
        managerWindow.setIsVisible(false)
        let task = createTask()
        array.append(task)
        resetManagerWindow()
    }
    
    func createTask() -> (Task) {
        let task = Task()
        task.name = taskTitleField.stringValue
        task.priority = taskPriorityField.stringValue
        task.date = taskDateField.dateValue
        task.links = taskLinkField.stringValue
        return task
    }
    
    func resetManagerWindow() {
        taskTitleField.stringValue = ""
        taskLinkField.stringValue = ""
        //TODO Reset other fields when I find out how
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    class Task {
        var name: String?;
        var priority: String?;
        var links: String?;
        var date: Date?;
    }
}

