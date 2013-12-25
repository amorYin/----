//
//  DCLastViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCLastViewController.h"
#import "DCMPMoviePlayerView.h"
#import "DCMovieInfoController.h"
#import "MJRefresh.h"
#import "DCVedioInfoView.h"
#import "DCAboutViewController.h"
#import "DCDropAnimation.h"
#import "ACSlender.h"

@interface DCLastViewController ()<MJRefreshBaseViewDelegate,MovieInfoActionDelegate,slender_button_delegate>
{
    char contentTag[3];
//    BOOL isSelect;
    MJRefreshHeaderView *_header;
    DCVedioInfoView *vedioInfo;
    slender_button *_slender_button;
    NSArray *test_dics;
}
@end

@implementation DCLastViewController

#pragma mark - apprarence
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
//        self.segment.alpha = 1.;
        _slender_button.alpha = 1.;
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.2 animations:^{
//        self.segment.alpha = 0.;
        _slender_button.alpha = 0.;
    }];
}

#pragma mark - 
- (void)slender_button_select:(int)index
{
    [self reachableViewAtIndex:index scroller:YES];
}

#pragma mark -
#pragma mark UISegmentedControl
- (void)reachableViewAtIndex:(NSInteger)index scroller:(BOOL)show
{
    //set the test back color
    NSArray *arr1 = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    index = index>=arr1.count?(arr1.count-1):index;
//    self.segment.selectedSegmentIndex = index;
    if (contentTag[index] == NO) {
        DCMovieInfoController *dayPaly;
//        if (index==0) {
//            dayPaly = [[DCMPMoviePlayerView alloc] initWithNibName:nil bundle:nil];
//            dayPaly.view.size = CGSizeMake( self.view.height, self.view.width-49-71);
//            dayPaly.view.origin = CGPointMake(self.view.width*index,0);
//            dayPaly.view.tag = 1000+index;
//            contentTag[index]=YES;
//            [(UIScrollView*)self.scrollerView addSubview:dayPaly.view];
//        }else{
            dayPaly = [[DCMovieInfoController alloc] initWithNibName:nil bundle:nil];
            dayPaly.view.size = CGSizeMake( self.view.width, self.view.height);
            dayPaly.view.origin = CGPointMake(self.view.width*index,0);
            dayPaly.view.tag = 1000+index;
            dayPaly.actionDelegate = self;
            contentTag[index]=YES;
            [(UIScrollView*)self.scrollerView addSubview:dayPaly.view];
//        }
        dayPaly.img = [UIImage imageNamed:[arr1 objectAtIndex:index]];
    }
    if (show) {
        UIScrollView *tempView = (UIScrollView*)[self.view viewWithTag:1000+index];
        _header.scrollView = (UIScrollView*)tempView;
        [(UIScrollView*)self.scrollerView scrollRectToVisible:tempView.frame animated:YES];
    }
    
    /*
     reset info content
     */
    vedioInfo.dictory = (NSDictionary*)[test_dics objectAtIndex:index];
    [vedioInfo revalInfo];
}

/*
//seg
- (void)changeNewView:(UISegmentedControl*)seg
{
    isSelect = YES;
    [self reachableViewAtIndex:seg.selectedSegmentIndex scroller:YES];
}
*/
#pragma mark -  refresh view delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) { // 下拉刷新
        //关闭界面切换
        self.segment.enabled = NO;
        self.scrollerView.scrollEnabled = NO;
        // 2秒后刷新表格
        [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
    }
}

#pragma mark - refresh
- (void)reloadDeals
{
    // 结束刷新状态
    [_header endRefreshing];
    //打开界面切换
    self.segment.enabled = YES;
    self.scrollerView.scrollEnabled = YES;
    
}

#pragma mark -
#pragma mark - (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat indexf = scrollView.contentOffset.x/scrollView.width;
    NSInteger index = ceil(indexf);
    [_slender_button scrollToIndex:index];
    [self reachableViewAtIndex:index scroller:NO];
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    isSelect = YES;
//}

#pragma mark - 
#pragma mark viewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // right navigationBar
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 48)];
    [btn setImage:[UIImage imageNamed:@"about_btn_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"about_btn_h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(showAblot) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn DD_AUTORELEASE];
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_s"]]];
    //refresh
    if (!_header) {
        _header = [MJRefreshHeaderView header];
        _header.delegate = self;
    }
    //segment
    /*
    if (!self.segment) {
        self.segment = [[UISegmentedControl alloc] initWithItems:@[@"今天",@"昨天",@"前天"]];
        self.segment.frame = CGRectMake(0, 0, 300, 33);
        
        [self.segment addTarget:self action:@selector(changeNewView:) forControlEvents:UIControlEventValueChanged];
        [self.navigationController.navigationBar addSubview:self.segment];
    }
    self.segment.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
     */
    if (!_slender_button) {
        _slender_button = [[slender_button alloc] initWithFrame:CGRectMake(0, 0, 210, 33) action:self];
        _slender_button.titles = [NSArray arrayWithObjects:@"今天",@"昨天",@"前天",nil];
        _slender_button.selectBgImg = [UIImage imageNamed:@"select_btn_h"];
        [self.navigationController.navigationBar addSubview:_slender_button];
    }
    
    if ([UIView iOSVersion]<7.0) {
    _slender_button.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY+4);
    }else{
    _slender_button.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
    }
    self.scrollerView.contentSize = CGSizeMake(self.view.height*3, 648);
    // add the movie info
    if (!vedioInfo) {
        vedioInfo = [[DCVedioInfoView alloc] initWithFrame:CGRectMake(0, 2, 300,650)];
        vedioInfo.backgroundColor = [UIColor colorWithRed:90/255 green:90/255 blue:90/255 alpha:0.4];
        [self.view addSubview:vedioInfo];
    }
    //test data
    test_dics = [[NSArray alloc] initWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.23",@"key1"
                  ,@"上架",@"key2"
                  ,@"公放期：还有三天",@"key3"
                  ,@"纽约时报的一年",@"key4"
                  ,@"Page One: A year inside the New York Times",@"key5"
                  ,@" 报纸媒体也许会消亡，但新闻不会。\r\n\r\n     这部纪录片在《纽约时报》报社内部拍摄一年，展现了这家古老而权威的传统媒体真实生存现状。《纽约时报》这样的传统媒体会倒闭吗？在电子信息洪流的冲击下，他们如何活着？这部影片让我们看到，在新旧媒体冲突猛烈的一年里，这个媒体巨头如何在新浪潮中艰难转身。",@"key6"
                  ,@"片长：78分钟",@"key7"
                  ,@"纽约时报的一年",@"key8"
                  ,@"详情：",@"key9"
                  ,@"《头版：纽约时报的一年》进入了对于外人来说充满着神秘色彩的《纽约时报》的编辑部，为观众介绍了一个成熟的媒体内部的运作环境和工作体系。影片曾参加2011年的圣丹斯电影节。\r\n\r\n     《纽约时报》以“为精英阶层出版严肃、庄重、有教养的报纸”著称，甚至傲气地说过这样一句话：报纸不该弄脏人们早餐的餐巾。泰坦尼克号沉船、一战、五角大楼秘密计划等一系列重大事件的优秀报道让它愈发名声显赫。但就是这样一份报纸，如今也在新媒体冲击下狼狈不堪。\r\n\r\n     2009年底，《纽约时报》因为财政危机不得不大规模裁员。那些为时报工作了几十年的员工，在这场新媒体的冲击中被率先无情地淘汰了。人们终于意识到报业严峻的形式，连《纽约时报》都如此惨淡，整个报业要怎么办？这样的恐慌情绪开始蔓延，《纽约时报》也不能再无动于衷",@"key10"
                  , nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.22",@"key1"
                  ,@"已上架",@"key2"
                  ,@"公放期：还有两天",@"key3"
                  ,@"妓女的荣耀",@"key4"
                  ,@"Whores' Glory",@"key5"
                  ,@"影片忠实地记录了在泰国的“金鱼缸”、孟加拉的贫民窟妓院以及墨西哥的红灯区，当地妓女的真实生活。没有表演与做作，镜头里是她们痛苦而无奈的生活，是被歧视被剥夺的尊严，也是惺惺相惜间的奋斗和挣扎。影片并没有从道德角度评价这些妓女的做法和行为，只是以旁观者的角度，让观众近距离了解妓女这个行业和她们生存的状态。",@"key6"
                  ,@"片长：56分钟",@"key7"
                  ,@"妓女的荣耀",@"key8"
                  ,@"详情：",@"key9"
                  ,@"在大众的观念里，性工作者从来不是能拿上台面的职业。人们轻视甚至蔑视这个职业，认为那些女人都是自轻自贱。于是导演米歇尔·格拉沃格举起摄像机，记录下这些妓女们的生存状态。这部影片是“全球化纪录片三部曲”的最后一部，并获得2011年威尼斯电影节评审团大奖。这部片子并没有从道德角度做出表态，只是以旁观者身份展现了这种特殊工作，把对娼妓文化的探讨留给大家。\r\n\r\n     何谓“妓女的荣耀”？用片中的一句话来解释，就是我卖身体，但不卖尊严。也许有人嗤之以鼻：卖都卖了何来尊严？ 但在片子里我们可以看到，这些妓女没有自我轻贱和贬低，只是不卑不亢的活着，有哭有笑的活着。这部影片不必有态度，因为愿意去真实展现她们的生活给世人看，就是一种尊重。",@"key10"
                  , nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.21",@"key1"
                  ,@"已上架",@"key2"
                  ,@"公放期：还有一天",@"key3"
                  ,@"青岛养老院的故事",@"key4"
                  ,@"The story of Qingdao nursing home.",@"key5"
                  ,@" NHK激流中国系列之养老篇，通过日本人的镜头来看清中国养老的无奈和困局。\r\n\r\n     在这所养老院中，老人们的晚年遭遇折射出各种养老问题，而距离影片已有6年的现在，这些现象依然愈演愈烈。“养儿防老”的说法，在计划生育的国策下成为老人的痛、儿女的难。影片共记录了四家老人的晚年境遇，类似的故事很可能就发生在我们身边。",@"key6"
                  ,@"片长：101分钟",@"key7"
                  ,@"青岛养老院的故事",@"key8"
                  ,@"详情：",@"key9"
                  ,@"拼搏了一辈子，为儿女奉献了一切，却在急剧的社会变动面前失去了自己的位置，只能孤独地终老于养老院中，无疑是一个巨大的悲剧。\r\n\r\n     传统中国家庭的老人，无疑享受着尊贵与荣耀，为这个家奉献了一辈子理应受到尊敬。但是，现代化的中国，人际关系包括家庭关系都面临着巨大的变化。老人边缘化无疑是现代社会丛林法则的另一种变体，当老人在这个社会中不再具有竞争力以后，被社会所抛弃似乎合情合理，但是，弃老人于不顾无疑与传统中国文化产生了巨大的背离，所以，董毓秀的女儿高桦将自己的母亲送到养老院之后，内心依然有剧烈的挣扎，这正是出于转型期的人的心理状态最真实的写照。",@"key10"
                  , nil]
                 , nil];
    // delay load the number view
    [self performSelector:@selector(load) withObject:nil afterDelay:0.1];
}

- (void)load
{
    //load movie
    [self reachableViewAtIndex:0 scroller:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)showAblot
{
    DCAboutViewController *about = [[[DCAboutViewController alloc] initWithNibName:nil bundle:nil] DD_AUTORELEASE];
    about.hidesBottomBarWhenPushed = YES;
    double delayInSeconds = 0.258;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController pushViewController:about animated:YES];
    });
}

#pragma mark - movie
//  share
- (void)share:(id)sender
{
    
}

//  play
- (void)play:(id)sender
{
    DCMPMoviePlayerView  *mmpplayer = [[DCMPMoviePlayerView alloc] initWithNibName:nil bundle:nil];
    mmpplayer.hidesBottomBarWhenPushed = YES;
    [mmpplayer playURLString:@"http://doco.u.qiniudn.com/201312251608207531?p/1/avthumb"];
    //delay initial load so statusBarOrientation returns correct value
    double delayInSeconds = 0.258;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:mmpplayer animated:YES];
    });
}

// download
- (void)download:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    //如果没有保存
    if (true) {
        [DCDropAnimation animationDropWith:btn  type:DCDropAnimationDownload];
    }
}

// incommit
- (void)incommit:(id)sender
{
    
}

@end
