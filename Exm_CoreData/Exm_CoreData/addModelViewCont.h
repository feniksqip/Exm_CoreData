//
//  addModelViewCont.h
//  Exm_CoreData
//
//  Created by Admin on 15.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addModelViewCont : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;
- (IBAction)saveButton:(id)sender;

@end
