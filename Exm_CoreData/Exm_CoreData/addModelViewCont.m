//
//  addModelViewCont.m
//  Exm_CoreData
//
//  Created by Admin on 15.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "addModelViewCont.h"
#import <CoreData/CoreData.h>

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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (touches in self.view.subviews) {
        [_nameField resignFirstResponder];
        [_numberField resignFirstResponder];
        [_companyField resignFirstResponder];
    }
}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)saveButton:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    
    NSManagedObject *newModel = [NSEntityDescription insertNewObjectForEntityForName:@"Model" inManagedObjectContext:context];
    [newModel setValue:self.nameField.text forKey:@"name"];
    [newModel setValue:self.numberField.text forKey:@"number"];
    [newModel setValue:self.companyField.text forKey:@"company"];
    
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ура!" message:@"Успешно добавлено!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    
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
