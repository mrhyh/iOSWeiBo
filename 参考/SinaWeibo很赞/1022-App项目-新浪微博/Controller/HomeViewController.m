//
//  HomeViewController.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "HomeViewController.h"
#import "DataManager.h"
#import "HomeTextCell.h"
#import "ImageOneCell.h"
#import "HomeNews.h"
#import "UITableViewCell+Config.h"
#import "Constant.h"
#import "MJRefresh.h"
#import "UserViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViewOfHome;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,assign) NSUInteger maxpage;
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic,strong) UIButton *plusButton;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewOfHome.dataSource=self;
    self.tableViewOfHome.delegate=self;
    self.tableViewOfHome.rowHeight=UITableViewAutomaticDimension;
    self.tableViewOfHome.estimatedRowHeight=150;
    self.page=1;
    self.data=[NSMutableArray new];
    
    
    
    //self.tableViewOfHome.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchDataOfHome)];
    self.tableViewOfHome.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(previousPage)];
    self.tableViewOfHome.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextPage)];
    
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"HomeTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeTextCell"];
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"ImageOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageOneCell"];
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"ImageTwoThreeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageTwoThreeCell"];
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"ImageFourCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageFourCell"];
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"ImageSevenCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageSevenCell"];
    //转发内容cell注册
    [self.tableViewOfHome registerNib:[UINib nibWithNibName:@"TransmitTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TransmitTextCell"];
   
    
    [self fetchDataOfHome];
    

    
    
}


-(void)fetchDataOfHome
{
    __weak typeof (self) weak_self=self;
    DataManager *manager=[DataManager shareManager];
    
    [manager requestNewsWithsuccessHome:^(NSArray *arr, NSUInteger maxpage)
    {
        if (arr)
        {
            weak_self.maxpage=maxpage;
            [weak_self.data addObjectsFromArray:arr];
            [weak_self.tableViewOfHome reloadData];
        }
        [weak_self.tableViewOfHome.header endRefreshing];
        [weak_self.tableViewOfHome.footer endRefreshing];
        
    } failedHome:^(NSError *error)
    {
        [weak_self.tableViewOfHome.header endRefreshing];
        [weak_self.tableViewOfHome.footer endRefreshing];
        
    }];
    
}
-(void)previousPage
{   //self.page++;
   self.data=[NSMutableArray new];//数据重新加载
    [self fetchDataOfHome];
}
-(void)nextPage
{
    self.page++;
    if (self.page>self.maxpage)
    {
        return; //结束该方法
    }
    [self fetchDataOfHome];
}


#pragma mark - 数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeNews *news=self.data[indexPath.row];
    if (news.imageOne &&news.imageTwo==nil)
    {
        UITableViewCell *cellA=[tableView dequeueReusableCellWithIdentifier:@"ImageOneCell" forIndexPath:indexPath];
        HomeNews *news=self.data[indexPath.row];
        [cellA configHomeCell:news];
        return cellA;
    }
    
    else if (news.imageOne&&news.imageFour==nil)
    {
     UITableViewCell *cellB=[tableView dequeueReusableCellWithIdentifier:@"ImageTwoThreeCell" forIndexPath:indexPath];
        [cellB configHomeCell:news];
         return cellB;
    }
    else if (news.imageOne&&news.imageSeven==nil)
    {
        UITableViewCell *cellD=[tableView dequeueReusableCellWithIdentifier:@"ImageFourCell" forIndexPath:indexPath];
        HomeNews *newsh=self.data[indexPath.row];
        [cellD configHomeCell:newsh];
        return cellD;
        
    }
    
  else if (news.imageOne&&news.imageSeven)
    {
        UITableViewCell *cellE=[tableView dequeueReusableCellWithIdentifier:@"ImageSevenCell" forIndexPath:indexPath];
        HomeNews *newsh=self.data[indexPath.row];
        [cellE configHomeCell:newsh];
        return cellE;
        
    }
    else if (news.retweeted_status&&news.transmitImageOne)
    {
        UITableViewCell *cellT=[tableView dequeueReusableCellWithIdentifier:@"TransmitTextCell" forIndexPath:indexPath];
        HomeNews *newsh=self.data[indexPath.row];
        [cellT configHomeCell:newsh];
        return cellT;
        
        
    }
    
    
    HomeTextCell *cellF=[tableView dequeueReusableCellWithIdentifier:@"HomeTextCell" forIndexPath:indexPath];
    HomeNews *newsh=self.data[indexPath.row];
    //cellF.selectionStyle=UITableViewCellSelectionStyleNone; //选中时的cell背景
    [cellF configHomeCell:newsh];
   
    [cellF setTapButtonOfHeadImageBlock:^(id obj) {
        
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"User" bundle:[NSBundle mainBundle]];
//        UIViewController *vb=[sb instantiateViewControllerWithIdentifier:@"UserViewController"];
//        [self.navigationController pushViewController:vb animated:YES];
//        
//        //给UserViewController传值
//        NSString *strOfName=news.screen_name;
//        NSString *strOfHeadImage=news.profile_image_url;
//        NSString *strOfGender=news.gender;
//        id Vip=news.verified;
//        id foucus=news.friends_count;
//        id fans=news.followers_count;
//        NSString *strOfDescript=news.descript;
//        [vb setValue:strOfName forKey:@"userName"];
//        [vb setValue:strOfHeadImage forKey:@"userHeadImage"];
//        [vb setValue:strOfGender forKey:@"userGender"];
//        [vb setValue:Vip forKey:@"userVip"];
//        [vb setValue:foucus forKey:@"focusCounts"];
//        [vb setValue:fans forKey:@"fansCounts"];
//        [vb setValue:strOfDescript forKey:@"descript"];
        
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"UserDetails" bundle:[NSBundle mainBundle]];
        UIViewController *vc=[sb instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        NSString *strOfId=news.idOfUser;
        [vc setValue:strOfId forKey:@"idOfUser"];
        
    }];
    
    return cellF;
  
}

//cell动画
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //1. Setup the CATransform3D structure
//    CATransform3D translation;
//    // rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    translation = CATransform3DMakeTranslation(0, 480, 0);
//    //rotation.m34 = 1.0/ -600;
//    
//    
//    //2. Define the initial state (Before the animation)
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    
//    cell.layer.transform = translation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    //!!!FIX for issue #1 Cell position wrong------------
//    if(cell.layer.position.x != 0)
//    {
//        cell.layer.position = CGPointMake(0, cell.layer.position.y);
//    }
//    
//    //4. Define the final state (After the animation) and commit the animation
//    
//    [UIView beginAnimations:@"translation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    
//    [UIView commitAnimations];
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 230;
//}


@end
