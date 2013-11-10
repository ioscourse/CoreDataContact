//
//  CoreDataContactViewController.h
//  CoreDataContact
//
//  Created by Charles Konkol on 11/9/13.
//  Copyright (c) 2013 Chuck Konkol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataContactAppDelegate.h"

@interface CoreDataContactViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *fullname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UILabel *status;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnFind:(id)sender;

@end
