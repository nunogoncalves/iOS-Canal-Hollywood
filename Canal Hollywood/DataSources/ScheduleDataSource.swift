//
//  ScheduleDataSource.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

protocol SelectorProtocol {
    func selectedRowWithMovie(scheduledMovie: ScheduledMovie)
    func setLastSelectedMovieCell(movieCell: MovieScheduleCell)
}

class ScheduleDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let schedulesTable: UITableView
    
    var selectorDelegate: SelectorProtocol?
    
    init(tableView: UITableView) {
        schedulesTable = tableView
        super.init()
    }
    
    var schedule: [ScheduledMovie] = []
    
    func load(date: NSDate, finishedCallback: ()->() = {}) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            self.schedule = ScheduleOfDayFetcher(date: date).fetch()
            dispatch_async(dispatch_get_main_queue()) {
                self.schedulesTable.reloadData()
                finishedCallback()
            }
        }
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieScheduleCell", forIndexPath: indexPath) as! MovieScheduleCell
        
        cell.scheduledMovie = schedule[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectorDelegate?.setLastSelectedMovieCell(tableView.cellForRowAtIndexPath(indexPath) as! MovieScheduleCell)
        return indexPath
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectorDelegate?.selectedRowWithMovie(schedule[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}