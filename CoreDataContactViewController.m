//
//  CoreDataContactViewController.m
//  CoreDataContact
//
//  Created by Charles Konkol on 11/9/13.
//  Copyright (c) 2013 Chuck Konkol. All rights reserved.
//

#import "CoreDataContactViewController.h"

@interface CoreDataContactViewController ()

@end

@implementation CoreDataContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize fullname,email, phone, status;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender {
    CoreDataContactAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
    [newContact setValue: fullname.text forKey:@"fullname"];
    [newContact setValue: email.text forKey:@"email"];
    [newContact setValue: phone.text forKey:@"phone"];
    fullname.text = @"";
    email.text = @"";
    phone.text = @"";
    NSError *error;
    [context save:&error];
    status.text = @"Contact saved";
}

- (IBAction)btnFind:(id)sender {
    CoreDataContactAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //http://stackoverflow.com/questions/2036094/case-insensitive-core-data-contains-or-beginswith-contraint
    //https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(fullname CONTAINS[cd] %@)",
     fullname.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        status.text = @"No matches";
    } else {
        matches = objects[0];
        fullname.text = [matches valueForKey:@"fullname"];
        email.text = [matches valueForKey:@"email"];
        phone.text = [matches valueForKey:@"phone"];
        status.text = [NSString stringWithFormat:
                       @"%lu matches found", (unsigned long)[objects count]];
    }
}
@end
