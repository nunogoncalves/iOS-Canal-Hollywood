//
//  ViewController.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController, DateDelegate {

    
    @IBOutlet weak var datePickerController: UIView!
    @IBOutlet weak var datePickerBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var gifWebView: UIWebView!
    @IBOutlet weak var scheduleTable: UITableView! {
        didSet { configureScheduleTable() }
    }
    
    var transition = TableCellAnimator()
    
    var lastSelectedRow: MovieScheduleCell?
    
    var dataSource: ScheduleDataSource!
    
    let datePickerAnimationDuration: NSTimeInterval = 0.3
    
    var selectedDate = NSDate()
    var selectedMovie: ScheduledMovie?
    
    override func viewWillAppear(animated: Bool) {
        scheduleTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.delegate = self
       
        let button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "calendar.png"), forState: .Normal)
        button.addTarget(self, action: "selectDay", forControlEvents: .TouchUpInside)
        button.frame = CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = barButton
        
        let filePath = NSBundle.mainBundle().pathForResource("waiting", ofType: "gif")!
        let gif = NSData(contentsOfFile: filePath)
        gifWebView.loadData(gif!, MIMEType: "image/gif", textEncodingName: "", baseURL: NSURL())
//        gifWebView.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
        gifWebView.contentMode = UIViewContentMode.Center
        gifWebView.scalesPageToFit = true
        gifWebView.contentMode = UIViewContentMode.Center
    
        scheduleTable.hidden = true
        gifWebView.hidden = false
        
        dataSource.load(NSDate()) {
            self.scheduleTable.hidden = false
            self.gifWebView.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.segues.datePickerSegue {
            (segue.destinationViewController as! DayPickerController).dateDelegator = self
        }
        
        if segue.identifier == Constants.segues.movieDetailsSegue {
            (segue.destinationViewController as! MovieDetailsController).movie = selectedMovie!
        }
    }
    
    func canceledDateSelection() {
        datePickerBottomConstraint.constant = -200
        datePickerController.superview?.setNeedsDisplay()
        
        UIView.animateWithDuration(datePickerAnimationDuration) {
            self.datePickerController.superview?.layoutIfNeeded()
        }
        
    }
    
    func gotDate(date: NSDate) {
        datePickerBottomConstraint.constant = -200
        datePickerController.superview?.setNeedsDisplay()
        
        UIView.animateWithDuration(datePickerAnimationDuration) {
            self.datePickerController.superview?.layoutIfNeeded()
        }

        if date != selectedDate {
            selectedDate = date
            navigationItem.title = date.stringFromDateInFormat("EEE, dd 'de' MMM 'de' YYYY")
            scheduleTable.hidden = true
            gifWebView.hidden = false
            dataSource.load(date) {
                self.scheduleTable.hidden = false
                self.gifWebView.hidden = true
            }
        }
    }
    
    func selectDay() {
        datePickerBottomConstraint.constant = 0
        datePickerController.superview?.setNeedsDisplay()
        
        UIView.animateWithDuration(datePickerAnimationDuration) {
            self.datePickerController.superview?.layoutIfNeeded()
        }
    }
    
    private func configureScheduleTable() {
        scheduleTable.superview?.backgroundColor = UIColor(patternImage: UIImage(named: "hollywood_bg.jpg")!)
        
        dataSource = ScheduleDataSource(tableView: scheduleTable)
        scheduleTable.dataSource = dataSource
        scheduleTable.delegate = dataSource
        dataSource.selectorDelegate = self
        scheduleTable.registerNib(UINib(nibName: "MovieScheduleCell", bundle: nil), forCellReuseIdentifier: "MovieScheduleCell")
    }
    
    var lastSelectedCell: MovieScheduleCell?
    
}

extension ScheduleController : SelectorProtocol {
    func selectedRowWithMovie(scheduledMovie: ScheduledMovie) {
        selectedMovie = scheduledMovie
        performSegueWithIdentifier(Constants.segues.movieDetailsSegue, sender: self)
    }
    
    func setLastSelectedMovieCell(cell: MovieScheduleCell) {
        lastSelectedCell = cell
    }
    
}

// MARK: navigation controller - custom transition methods

extension ScheduleController : UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Pop {
            return nil
        }
        return transition
    }
}
