//
//  PhotosViewController.m
//  
//
//  Created by Liz Chaddock on 9/14/15.
//
//

#import "PhotosViewController.h"
#import "PhotosTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoDetailsViewController.h"

@interface PhotosViewController ()
@property NSArray *media;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation PhotosViewController

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"..."];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.rowHeight = 320;
    
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=3581125fb68441e8967a2a20b17aec4d"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.media = responseDictionary[@"data"];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (PhotosTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.photoCell"];
    NSString *urlString = self.media[indexPath.row][@"images"][@"low_resolution"][@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.imageViewCell setImageWithURL:url];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PhotoDetailsViewController *photoDetailsViewController = [segue destinationViewController];
    
    //get the index path of the selected photo
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    if ([segue.identifier isEqual:@"segueToDetails"]){
        photoDetailsViewController.selectedPhoto = self.media[indexPath.row];
    }
}


@end
