//
//  PhotoDetailsViewController.m
//  instagramLab
//
//  Created by Liz Chaddock on 9/14/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "DetailPhotoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 320;
    
    /*
    NSString *url = self.selectedPhoto[@"images"][@"low_resolution"][@"url"];

    UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];

    [self.image setImage:im];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DetailPhotoTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
   if (!cell) {
        cell = [[DetailPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:@"detailCell"];
   }
    
    NSString *urlString = self.selectedPhoto[@"images"][@"low_resolution"][@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.detailPhoto setImageWithURL:url];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
