//
//  ViewController.m
//  Exm_CoreData
//
//  Created by Admin on 15.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface ViewController ()
@property (strong) NSMutableArray *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Model"];
    self.model = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSManagedObject *model = [self.model objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@", [model valueForKey:@"name"],[model valueForKey:@"number"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [model valueForKey:@"company"]];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [managedObjectContext deleteObject:[self.model objectAtIndex:indexPath.row]];
    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
      //  NSLog(@"Не удалось удалить... %@ %@", error,[error localizedDiscription] );
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
