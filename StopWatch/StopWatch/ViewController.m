//
//  ViewController.m
//  StopWatch
//
//  Created by RNTD009 on 2017/4/28.
//  Copyright © 2017年 ZengYangYang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

#define kW self.view.frame.size.width

#define kH self.view.frame.size.height

{
    
    NSTimer * _timer;  //定时器
    
    NSInteger _seconds;
    
}


//开始暂停按钮

@property (nonatomic,weak) UIButton * ssButton;


//清零按钮
@property (nonatomic,weak) UIButton * zeroButton;


//计次按钮

@property (nonatomic,weak) UIButton * jcButton;


//右上角计次时间

@property (nonatomic,weak) UILabel * conLabel;


//中间秒表

@property (nonatomic,weak) UILabel * ctLabel;


//下面的每次记录的时间

@property (nonatomic,weak) UITableView * tableView;


//

@property (nonatomic,weak) UITableViewCell * cell;


//存放记录的数组

@property (nonatomic,strong) NSMutableArray * jcArray;


@property (nonatomic,assign) int count;


@property (nonatomic,assign) BOOL states;


@end


@implementation ViewController


#pragma mark - 懒加载

-(int)getNum{
    
    return 100;
    
}

- (NSMutableArray *)jcArray

{
    
    if (_jcArray==nil)
        
    {
        
        _jcArray=[NSMutableArray array];
        
    }
    
    return  _jcArray;
    
}


#pragma mark - 入口

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"my"]];
                        
    [self.view setBackgroundColor:bgColor];
    
    _states = YES;
    
    [self _loadViews];
    
}


- (void) _loadViews

{
    
    self.title=@"秒表";
    
    //小时钟---一直计时
    
    UILabel * conLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 65, 110, 50)];
    
    //conLabel.backgroundColor=[UIColor redColor];
    
    conLabel.text=@"0";
    
    conLabel.font=[UIFont fontWithName:nil size:30];
    
    self.conLabel=conLabel;
    
    [self.view addSubview:conLabel];
    
    
    
    //秒表
    
    UILabel * ctLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,110,kW,150)];
    
    //ctLabel.backgroundColor=[UIColor redColor];
    
    ctLabel.text=@"00:00.00";
    
    ctLabel.textAlignment=NSTextAlignmentCenter;
    
    ctLabel.font=[UIFont fontWithName:nil size:75];
    
    self.ctLabel=ctLabel;
    
    [self.view addSubview:ctLabel];
    
    
    
    //下方视图
    
    UIView * bView=[[UIView alloc]initWithFrame:CGRectMake(0,230,kW,140)];
    
    bView.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    
    
    
    [self.view addSubview:bView];
    
    
    
    //NSLog(@"%f",bView.frame.origin.y);
    
    
    
    //开始停止按钮
    
    UIButton * ssButton=[[UIButton alloc]initWithFrame:CGRectMake((kW-240)/3, 20, 80, 80)];
    
    ssButton.backgroundColor=[UIColor whiteColor];
    
    ssButton.layer.cornerRadius=40;
    
    [ssButton setTitle:@"开始" forState:UIControlStateNormal];
    
    [ssButton setTitle:@"停止" forState:UIControlStateSelected];
    
    [ssButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [ssButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    
    
    
    ssButton.tag=1;
    
    [ssButton addTarget:self action:@selector(StartStop:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ssButton=ssButton;
    
    [bView addSubview:ssButton];
    
    
    
    
    
    //计次按钮
    
    UIButton * jcButton=[[UIButton alloc]initWithFrame:CGRectMake(((kW-240)/4)*2+80, 20, 80, 80)];
    
    jcButton.backgroundColor=[UIColor whiteColor];
    
    jcButton.layer.cornerRadius=40;
    
    [jcButton setTitle:@"计次" forState:UIControlStateNormal];
    
    [jcButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [jcButton addTarget:self action:@selector(CountNum) forControlEvents:UIControlEventTouchUpInside];
    
    self.jcButton=jcButton;
    
    [bView addSubview:jcButton];
    
    
    
    //清零按钮
    
    UIButton * zeroButton=[[UIButton alloc]initWithFrame:CGRectMake(((kW-240)/4)*3+160, 20, 80, 80)];
    
    zeroButton.backgroundColor=[UIColor whiteColor];
    
    zeroButton.layer.cornerRadius=40;
    
    [zeroButton setTitle:@"清零" forState:UIControlStateNormal];
    
    [zeroButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [zeroButton addTarget:self action:@selector(setZero) forControlEvents:UIControlEventTouchUpInside];
    
    self.zeroButton=zeroButton;
    
    [bView addSubview:zeroButton];
    
    
    
    //点击计次按钮时记录的每次时间,存放到对应的cell上
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 370, kW, kH-370-60) style:UITableViewStylePlain];
    
    tableView.rowHeight=50;
    
    tableView.alpha = 0.5;
    
    tableView.delegate=self;
    
    tableView.dataSource=self;
    
    self.tableView=tableView;
    
    [self.view addSubview:tableView];
    
}



#pragma mark - ssButton按钮的点击事件

- (void)StartStop:(UIButton *) button

{
    button.selected = !button.selected;
    
    if(_states)
        
    {
        //每隔0.01秒刷新一次页面
        
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(runAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        NSLog(@"开始计时.....");
        
        _states = NO;
        
    }
    
    else
        
    {
        [_timer invalidate];
        
        _states = YES;
        
        
    }
    
}

-(void)setZero
{

    [_timer invalidate];   //让定时器失效

    _timer=nil;

    _ctLabel.text=@"00:00.00";

    _conLabel.text=@"0";

    _seconds= 0;
    
    _count = 0;

    self.cell=nil;

    self.jcArray=nil;
    
    [self.tableView reloadData];
    
    _ssButton.selected = NO;

    NSLog(@"计时停止.....");
}

#pragma mark - runAction

- (void) runAction

{
  
        _seconds++;
        
        //动态改变开始时间
        
        NSString * startTime=[NSString stringWithFormat:@"%02li:%02li.%02li",_seconds/100/60%60,_seconds/100%60,_seconds%100];
        
        _ctLabel.text=startTime;
    
    
}


#pragma mark - 计次

- (void)CountNum

{
    if (_ssButton.selected) {
        _count++;
        
        _conLabel.text= [NSString stringWithFormat:@"%d",_count];
        
        // NSLog(@"这是记录的第**** %i ****个时间数据: %@",count,_conLabel.text);
        
        [self.jcArray addObject:_ctLabel.text];
        
        //    NSLog(@"%@",self.jcArray);
        
        
        
        [self.tableView reloadData];
    }

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.jcArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString * identy=@"JRTable";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell==nil)
        
    {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        
        //增加label
        
        //        UILabel * cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kW, tableView.rowHeight)];
        
        //        cellLabel.text=self.jcArray[indexPath.row];
        
        //        cellLabel.textAlignment=NSTextAlignmentCenter;
        
        //        [cell.contentView addSubview:cellLabel];
        
    }
    
    //NSLog(@"%@",self.jcArray[indexPath.row]);
    
    cell.textLabel.text = self.jcArray[indexPath.row];
    
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    self.cell=cell;
    
    return  self.cell;
    
}

@end
