//
//  LeftViewController.m
//  FeyddyWeiBo
//
//  Created by Mac on 15/10/10.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"
#import "ThemeButton.h"
#import "Common.h"
#import "BaseTabBarController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ConsultViewController.h"
#import "ConsultListViewController.h"
#import "RightViewController.h"
#import "RecommendViewController.h"
#import "ConsultDetailViewController.h"
#import "BaseNavigationController.h"
#import "BookViewController.h"
#import "BookListViewController.h"
#import "BookDetailViewController.h"
#import "MenuViewController.h"
#import "MenuListViewController.h"
#import "MenuShowViewController.h"

#import "RegistViewController.h"
#import "LoginViewController.h"
#import "BookRecommendViewController.h"
#import "WebViewController.h"
#import "HandleViewController.h"


@interface LeftViewController ()
{
    UITableView *_leftTableView;
    NSArray *_titleArray;
    NSArray *_consultDetailArray;
    NSArray *_bookDetailArray;
    NSArray *_menuDetailArray;
    NSArray *_personDetailArray;
    BaseTabBarController *_baseTab;
    MMDrawerController *mmDraw;
    int number;
    CGFloat _width;
    int consultRow;
    int bookRow;
    int menuRow;
    int personRow;
    UILabel *_titleLabel;
    UIView *_selectedView;
    NSArray *comsultImageNames;
    NSArray *bookImageNames;
    NSArray *menuImageNames;
    NSArray *personImageNames;
    
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"首页";
    
    self.navigationItem.titleView = titleLabel;
    
     _width = (kScreenHeight-100) / 4;
    
    //04创建TabBar按钮

    NSArray *names = @[@"home_tab_icon_4.png",
                       @"home_tab_icon_1.png",
                       @"home_tab_icon_2.png",
                       @"home_tab_icon_3.png"
                       
                       ];
    NSArray *tabButtonNames = @[@"咨询",@"图书",@"菜谱",@"个人"];
    
    for (int i = 0; i < names.count; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 85+i * _width, 80, 80)];
        button.bgNormalImageName = names[i];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 85+i * _width + 80, 80, _width-80)];
        label.text = tabButtonNames[i];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:label];
        button.tag = i;
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(80, 85, 5, _width)];
    _selectedView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_selectedView];
    
    _titleArray = @[@"健康咨询",@"健康图书",@"健康菜谱",@"个人中心"];
    _consultDetailArray = @[@"咨询之家",@"最新咨询",@"咨询推荐",@"更新"];
    consultRow = (int)_consultDetailArray.count / 2;
    _bookDetailArray = @[@"图书之家",@"最新推荐",@"宝宝知识",@"更新"];
    bookRow = (int)_bookDetailArray.count / 2;
    _menuDetailArray = @[@"菜单之家",@"最新菜单",@"营养学说",@"更新"];
    menuRow = (int)_menuDetailArray.count / 2;
    _personDetailArray = @[@"登陆/注册",@"清除缓存",@"操作说明",@"版本更新"];
    personRow = (int)_personDetailArray.count / 2;
    
    
    

    //标签栏标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 120 , 120)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:30];
 
}
- (void)viewWillAppear:(BOOL)animated
{
    [self _createView];
}

- (void)_createView
{
    
    comsultImageNames = @[@"consult_1",@"consult_2",@"consult_3",@"consult_4"];
    bookImageNames = @[@"book_1",@"book_2",@"book_3",@"book_4"];
    menuImageNames = @[@"menu_1",@"menu_2",@"menu_3",@"menu_4"];
    personImageNames = @[@"person_1",@"person_2",@"person_3",@"person_4"];
    //全部视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(90,85, kScreenWidth - 120 , kScreenHeight- 100)];
    view.layer.borderColor = [[UIColor grayColor]CGColor];
    view.layer.borderWidth = 2;
    view.backgroundColor = [UIColor colorWithRed:210/255.0 green:237/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:view];

    //标题
    _titleLabel.text = nil;
    _titleLabel.text = _titleArray[number];
    [view addSubview:_titleLabel];
    
    //循环创建按钮
    CGFloat viewWidth = view.bounds.size.width/2;
    CGFloat viewHeight = (view.bounds.size.height-120)/2;

    switch (number) {
        case 0:
            for (int i = 0; i < _consultDetailArray.count; i++) {

                
                if (i <= 1) {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * viewWidth,120, viewWidth, viewHeight)];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];

                    [button setTitle:_consultDetailArray[i] forState:UIControlStateNormal];
                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:comsultImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    [button addTarget:self action:@selector(consultAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    [view addSubview:button];
                    
                }else if (i>=2)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-2) * viewWidth, 120+viewHeight, viewWidth, viewHeight)];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    [button setTitle:_consultDetailArray[i] forState:UIControlStateNormal];
                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:comsultImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];

                    [button addTarget:self action:@selector(consultAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                }
                
            }
            break;
        case 1:
            for (int i = 0; i < _bookDetailArray.count; i++) {
                
                
                if (i <= 1) {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * viewWidth, 120, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitle:_bookDetailArray[i] forState:UIControlStateNormal];
        
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:bookImageNames[i]] forState:UIControlStateNormal];
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    
                    [button addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                    
                }else if (i>=2)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-2) * viewWidth, 120+viewHeight, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    
                    
                   [button setImage:[UIImage imageNamed:bookImageNames[i]] forState:UIControlStateNormal];
                    
                    [button setTitle:_bookDetailArray[i] forState:UIControlStateNormal];

                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
 
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    [button addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                }
                
            }
            break;
        case 2:
            for (int i = 0; i < _menuDetailArray.count; i++) {
                
                
                if (i <= 1) {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * viewWidth, 120, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitle:_menuDetailArray[i] forState:UIControlStateNormal];

                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:menuImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                    
                }else if (i>=2)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-2) * viewWidth, 120+viewHeight, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitle:_menuDetailArray[i] forState:UIControlStateNormal];

                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:menuImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                }
                
            }
            break;
        case 3:
            for (int i = 0; i < _personDetailArray.count; i++) {
                
                
                if (i <= 1) {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * viewWidth,120, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitle:_personDetailArray[i] forState:UIControlStateNormal];
                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:personImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];

                    [button addTarget:self action:@selector(personAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                    
                }else if (i>=2)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-2) * viewWidth, 120+viewHeight, viewWidth, viewHeight)];
                    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = .5;
                    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                    [button setTitle:_personDetailArray[i] forState:UIControlStateNormal];
                    
                    
                    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [button setImage:[UIImage imageNamed:personImageNames[i]] forState:UIControlStateNormal];
                    
                    //设置标题label的偏移量
                    
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, -120, -120, 0)];
                    //设置图片偏移量
                    [button setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0,0)];
                    [button addTarget:self action:@selector(personAction:) forControlEvents:UIControlEventTouchUpInside];
                    [view addSubview:button];
                }
            }
            break;
        default:
            break;
    }
}

- (void)consultAction:(UIButton *)button
{
    
    if ([button.titleLabel.text isEqualToString:@"咨询之家"])
    {
        //NSLog(@"zixun 点击");
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
    else if ([button.titleLabel.text isEqualToString:@"最新咨询"])
    {
        //NSLog(@"详情点击");
        [self.navigationController pushViewController:[[ConsultListViewController alloc] init] animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"咨询推荐"])
    {
       // NSLog(@"推荐点击");
        [self.navigationController pushViewController:[[RecommendViewController alloc] init] animated:YES];
    }
    
    
}
-(void)bookAction:(UIButton *)button
{
    
    if ([button.titleLabel.text isEqualToString:@"图书之家"])
    {
       // NSLog(@"分类点击");
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];

    }
    else if ([button.titleLabel.text isEqualToString:@"最新推荐"])
    {
        //NSLog(@"详情点击");
        [self.navigationController pushViewController:[[BookListViewController alloc] init] animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"宝宝知识"])
    {
        //NSLog(@"推荐点击");
        
        [self.navigationController pushViewController:[[BookRecommendViewController alloc] init] animated:YES];
    }
}
- (void)menuAction:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"菜单之家"])
    {
        MMDrawerController *mmDraw1 = self.mm_drawerController;
        [mmDraw1 closeDrawerAnimated:YES completion:nil];
        NSLog(@"分类点击");
    }
    else if ([button.titleLabel.text isEqualToString:@"最新菜单"])
    {
        NSLog(@"详情点击");
        [self.navigationController pushViewController:[[MenuListViewController alloc] init] animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"营养学说"])
    {
        NSLog(@"推荐点击");
        [self.navigationController pushViewController:[[WebViewController alloc] init] animated:YES];
    }
    
}

-(void)personAction:(UIButton *)button
{
    if([button.titleLabel.text isEqualToString:@"登陆/注册"])
    {
        [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    }
    else if([button.titleLabel.text isEqualToString:@"清除缓存"])
    {
        //弹出一个提示框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%.2fMB缓存",[self countCacheFileSize]] message:@"是否清理缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        
    }
    else if ([button.titleLabel.text isEqualToString:@"操作说明"])
    {
        [self.navigationController pushViewController:[[HandleViewController alloc] init] animated:YES];
    }
    else if([button.titleLabel.text isEqualToString:@"版本更新"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"正在玩命更新中" message:@"敬请期待" delegate:self cancelButtonTitle:@"加油！" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)selectedAction:(UIButton *)button
{
     mmDraw= self.mm_drawerController;
    _baseTab = (BaseTabBarController *)mmDraw.centerViewController;
    _baseTab.selectedIndex = button.tag;
    number = (int)_baseTab.selectedIndex;
    [UIView animateWithDuration:0.3 animations:^{
        _selectedView.frame = CGRectMake(80, 85+button.tag * _width, 5,  _width);
    }];
    
    [self _createView];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        //清除缓存
        //NSString *homePath = NSHomeDirectory();
        //NSLog(@"homePath = %@",homePath);
        [self clearCacheFile];
        if([self countCacheFileSize] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清理完毕" message:nil delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
}
#pragma mark - 计算当前缓存文件大小
/**
 *  计算当前应用程序缓存文件的大小之和
 *
 *  @return 文件大小
 */
-(CGFloat)countCacheFileSize
{
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒文件
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    /*1)子文件夹1 视频缓存/tmp/MediaCache/
     2)子文件夹2 SDWebImage框架的缓存图片 /Library/Caches/com.hackemist.SDWebImageCache.default/
     3)子文件夹3/Library/Caches/com.Janie.----Healthyguns/
     */
    //2.使用-(CGFloat)getFileSize:(NSString *)filePath 来计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/cn.Feyddy.----healthy-guys/"];
    //文件大小之和
    CGFloat fileSize = 0;
    for(NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        fileSize += [self getFileSize:filePath];
    }
    //3.对上一步计算结果进行求和 并返回
    return fileSize;
}
/**
 *  根据传入的路径 计算此路径下的文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 此文件夹下所有文件的总大小  单位MB
 */

-(CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理器对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    //数组 储存文件夹中所有的子文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    //遍历文件夹
    long long size = 0;
    for(NSString *fileName in fileNames)
    {
        //拼接获取文件路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        NSLog(@"%@",dic);
        //获取单个文件大小
        NSNumber *sizeNumber = dic[NSFileSize];
        //使用一个long long类型来储存文件大小
        long long subFileSize = [sizeNumber longLongValue];
        //文件大小求和
        size += subFileSize;
        
    }
    return size/1024.0/1024;
    
}
#pragma mark - 清理缓存
-(void)clearCacheFile
{
    //1.获取缓存文件路径
    NSString *homePath = NSHomeDirectory();
    //2.删除文件
    
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/cn.Feyddy.----healthy-guys/"];
    
    for(NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        //文件管理
        NSFileManager *manager = [NSFileManager defaultManager];
        //获取自文件中的文件名
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        //遍历文件夹 删除文件
        for(NSString *fileName in fileNames)
        {
            //拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
