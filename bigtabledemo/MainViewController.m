//
//  MainViewController.m
//  bigtabledemo
//
//  Created by Anthony Sherbondy on 7/9/14.
//  Copyright (c) 2014 Anthony Sherbondy. All rights reserved.
//

#import "MainViewController.h"
#import "UserCell.h"
#import "PhotoCell.h"
#import <UIImageView+AFNetworking.h>
#import "PhotoViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *photos;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=cacf259aa44c4be7a16aec017a0e3dc4"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"%@", object);
            self.photos = object[@"data"];
            
            [self.tableView reloadData];
            
        }];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"PhotoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PhotoCell"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Header";
    [headerView addSubview:label];
    self.tableView.tableHeaderView = headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSString *url = self.photos[indexPath.section][@"images"][@"standard_resolution"][@"url"];
    NSLog(@"url: %@", url);
    [cell.myImageView setImageWithURL:[NSURL URLWithString:url]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.photos.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:.2];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 20)];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = self.photos[section][@"user"][@"username"];
    [headerView addSubview:label];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PhotoViewController *vc = [[PhotoViewController alloc] init];
    
    NSString *url = self.photos[indexPath.section][@"images"][@"standard_resolution"][@"url"];
    vc.url = url;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
