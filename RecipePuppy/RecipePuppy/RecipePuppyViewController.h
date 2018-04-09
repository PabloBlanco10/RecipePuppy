//
//  RecipePuppyViewController.h
//  RecipePuppy
//
//  Created by Pablo Blanco Peris on 9/4/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipePuppyViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
