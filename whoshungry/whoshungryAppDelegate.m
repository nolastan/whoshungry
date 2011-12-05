//
//  whoshungryAppDelegate.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "whoshungryAppDelegate.h"
#import "begin.h"
#import "User.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation whoshungryAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSArray *contacts = (NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableDictionary *peopleDict = [[NSMutableDictionary alloc] init];
    
    if (contacts == nil) {
         
        NSLog(@"No contacts");
    }else {
        for (int i = 0; i < [contacts count]; ++i) {
            
            ABRecordRef person = (ABRecordRef)[contacts objectAtIndex:i];
            ABMutableMultiValueRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            
            ABMutableMultiValueRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);

            ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue( person, kABPersonPhoneProperty);
            CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
            
            NSLog(@"Name : %@ %@", firstName, lastName);
            NSLog(@"Number: %@", phoneNumber);
            
            [peopleDict setValue:@"%@" forKey:@"value"];
            
        }
    }
    
    
    
    UIViewController *beginControl = [[[begin alloc] init] autorelease];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:beginControl];
    
    
    [self.window addSubview:nav.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
