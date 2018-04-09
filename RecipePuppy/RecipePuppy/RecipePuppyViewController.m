//
//  RecipePuppyViewController.m
//  RecipePuppy
//
//  Created by Pablo Blanco Peris on 9/4/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

#import "RecipePuppyViewController.h"
#import "RecipePuppy.h"
#import "RecipePuppyTableViewCell.h"
#import "RecipePuppyDetailViewController.h"

#define kLinkRecipePuppy @"http://www.recipepuppy.com/api/?q="

#define kDetailSegue @"detailSegue"

#define kTitle @"title"
#define kHref @"href"
#define kIngredients @"ingredients"
#define kThumbnail @"thumbnail"

@interface RecipePuppyViewController ()
@property (nonatomic) NSMutableData * responseData;
@property (nonatomic) NSDictionary *response;
@property (nonatomic) NSMutableArray *objects;
@property (nonatomic) RecipePuppy *objectSelected;


@end

@implementation RecipePuppyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.objects = [[NSMutableArray alloc] initWithCapacity:100];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureView{
    
    [self.searchTextField setPlaceholder:@"Chicken"];
    [self.navigationItem setTitle:@"Recipe Puppy"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void) callService:(NSString*) recipe{
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kLinkRecipePuppy, recipe];
    NSURL *URL = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(20, 80);
    spinner.tag = 12;
    
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          self.responseData = (NSMutableData*)data;
                                          NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          self.response = [jsonArray objectForKey:@"results"];
                                          [self getData];
                                      });
                                  }];
    
    [task resume];
    
}

- (void) getData{
    self.objects = [[NSMutableArray alloc] initWithCapacity:100];
    for(id i in self.response){
        RecipePuppy* newObject = [[RecipePuppy alloc] init];
        newObject.title = i[kTitle];
        newObject.href = i[kHref];
        newObject.ingredients = i[kIngredients];
        newObject.thumbnail = i[kThumbnail];
        [self.objects addObject:newObject];
    }
    [[self.view viewWithTag:12] removeFromSuperview];
    [self.tableView reloadData];
}


#pragma mark - Textfield Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@"\n"] || [string isEqualToString:@" "]){
        [textField resignFirstResponder];
        return NO;
    }
    [self callService:[NSString stringWithFormat:@"%@%@", self.searchTextField.text, string]];
    return YES;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipePuppyTableViewCell * cell = (RecipePuppyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"kCell"];
    cell.title.text = ((RecipePuppy*)self.objects[indexPath.row]).title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchTextField resignFirstResponder];
    self.objectSelected = self.objects[indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kDetailSegue]){
        RecipePuppyDetailViewController *destination = segue.destinationViewController;
        destination.objectSelected = self.objectSelected;
    }
}



@end
