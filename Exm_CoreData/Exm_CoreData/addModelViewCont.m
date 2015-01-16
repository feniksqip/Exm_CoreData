//
//  addModelViewCont.m
//  Exm_CoreData
//
//  Created by Admin on 15.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "addModelViewCont.h"

@interface addModelViewCont ()

@end

@implementation addModelViewCont

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:tapGesture];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    [_nameField resignFirstResponder];
    [_numberField resignFirstResponder];
    [_companyField resignFirstResponder];
}

//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *_managedObjectContext;
//    if(_managedObjectContext != nil){
//        return _managedObjectContext;
//    }
//    
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if(coordinator != nil){
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    
//    return _managedObjectContext;
//}

@end
