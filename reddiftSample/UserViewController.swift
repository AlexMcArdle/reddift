//
//  UserViewController.swift
//  reddift
//
//  Created by sonson on 2015/04/14.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation
import reddift

class UserViewController: UITableViewController {
    var session:Session?
    @IBOutlet var expireCell:UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateExpireCell(sender:AnyObject?) {
        print(NSThread.isMainThread())
        if let token = session?.token {
            expireCell.detailTextLabel?.text = NSDate(timeIntervalSinceReferenceDate:token.expiresDate).description
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        if indexPath.row == 2 && indexPath.section == 0 {
            do {
                try self.session?.refreshToken({ (result) -> Void in
                    switch result {
                    case .Failure(let error):
                        print(error)
                    case .Success(let token):
                        print(token)
                        self.updateExpireCell(nil)
                    }
                })
            }
            catch { print(error) }
        }
        if indexPath.row == 3 && indexPath.section == 0 {
            do {
                try self.session?.revokeToken({ (result) -> Void in
                    switch result {
                    case .Failure(let error):
                        print(error)
                    case .Success(let token):
                        print(token)
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
                })
            }
            catch { print(error) }
        }
        
        if indexPath.section == 3 {
            if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("UserContentViewController") as? UserContentViewController {
                let content = [
                    UserContent.Overview,
                    UserContent.Submitted,
                    UserContent.Comments,
                    UserContent.Liked,
                    UserContent.Disliked,
                    UserContent.Hidden,
                    UserContent.Saved,
                    UserContent.Gilded
                ]
                vc.userContent = content[indexPath.row]
                vc.session = self.session
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        updateExpireCell(nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        print(session)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToProfileViewController" {
            if let con = segue.destinationViewController as? ProfileViewController {
                con.session = self.session
            }
        }
        else if segue.identifier == "ToFrontViewController" {
            if let con = segue.destinationViewController as? LinkViewController {
                con.session = self.session
            }
        }
        else if segue.identifier == "ToSubredditsListViewController" {
            if let con = segue.destinationViewController as? SubredditsListViewController {
                con.session = self.session
            }
        }
        else if segue.identifier == "ToSubredditsViewController" {
            if let con = segue.destinationViewController as? SubredditsViewController {
                con.session = self.session
            }
        }
		else if segue.identifier == "OpenInbox" {
			if let con = segue.destinationViewController as? MessageViewController {
				con.session = self.session
				con.messageWhere = .Inbox
			}
		}
		else if segue.identifier == "OpenSent" {
			if let con = segue.destinationViewController as? MessageViewController {
				con.session = self.session
				con.messageWhere = .Sent
			}
		}
		else if segue.identifier == "OpenUnread" {
			if let con = segue.destinationViewController as? MessageViewController {
				con.session = self.session
				con.messageWhere = .Unread
			}
		}
    }
}
