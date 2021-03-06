//
//  ViewController.m
//  Exm_CoreData
//
//  Created by Admin on 15.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "addModelViewCont.h"

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
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject:[self.model objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if(![context save:&error]){
            NSLog(@"Не возможно удалить... %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.model removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"UpdateModel"]){
        NSManagedObject *managedObject = [self.model objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        addModelViewCont *addModelVCtrl = segue.destinationViewController;
        addModelVCtrl.model = managedObject;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
