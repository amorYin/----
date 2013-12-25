//
//  DCNewViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCNewViewController.h"
#import "DCMPMoviePlayerView.h"
#import "DCMovieInfoController.h"
#import "MJRefresh.h"
#import "DCVedioInfoView.h"
#import "DCAboutViewController.h"
#import "ACSlender.h"

@interface DCNewViewController ()<MJRefreshBaseViewDelegate,MovieInfoActionDelegate,slender_button_delegate>
{
    char contentTag[3];
//    BOOL isSelect;
    MJRefreshHeaderView *_header;
    DCVedioInfoView *vedioInfo;
    slender_button *_slender_button;
    NSArray *test_dics;
}
@end

@implementation DCNewViewController

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
    NSArray *arr1 = @[@"2.jpg",@"3.jpg",@"1.jpg"];
    //set the invalidate index
    index = index>=arr1.count?(arr1.count-1):index;
//        self.segment.selectedSegmentIndex = index;
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
        dayPaly.controllerStyle = MovieInfoControllerTypeNews;
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
    /*
    if (isSelect) {return;}
    CGFloat indexf = scrollView.contentOffset.x/scrollView.width;
    NSInteger index = ceil(indexf);
    [self reachableViewAtIndex:index scroller:NO];
     */
    CGFloat indexf = scrollView.contentOffset.x/scrollView.width;
    NSInteger index = ceil(indexf);
    [_slender_button scrollToIndex:index];
    [self reachableViewAtIndex:index scroller:NO];
}
/*

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    isSelect = NO;
}

 */
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
    /*
    //segment
    if (!self.segment) {
        self.segment = [[UISegmentedControl alloc] initWithItems:@[@"明天",@"后天",@"大后天"]];
        self.segment.frame = CGRectMake(0, 0, 300, 33);
        
        [self.segment addTarget:self action:@selector(changeNewView:) forControlEvents:UIControlEventValueChanged];
        [self.navigationController.navigationBar addSubview:self.segment];
    }
    
    self.segment.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
     */
    
    if (!_slender_button) {
        _slender_button = [[slender_button alloc] initWithFrame:CGRectMake(0, 0, 210, 33) action:self];
        _slender_button.titles = [NSArray arrayWithObjects:@"明天",@"后天",@"大后天",nil];
        _slender_button.selectBgImg = [UIImage imageNamed:@"select_btn_h"];
        [self.navigationController.navigationBar addSubview:_slender_button];
    }
#ifndef __IPHONE_7
    _slender_button.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY+4);
#else
    _slender_button.center = CGPointMake(AppFrame.height*0.5,self.navigationController.navigationBar.centerY*0.5);
#endif
    self.scrollerView.contentSize = CGSizeMake(self.view.height*3, 648);
    
    // add the movie info
    if (!vedioInfo) {
        vedioInfo = [[DCVedioInfoView alloc] initWithFrame:CGRectMake(0, 2, 300,644)];
        vedioInfo.infoViewStyle = VedioInfoViewTypeNews;
        vedioInfo.backgroundColor = [UIColor colorWithRed:90/255 green:90/255 blue:90/255 alpha:0.4];
        [self.view addSubview:vedioInfo];
    }
    
    //test data
    test_dics = [[NSArray alloc] initWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.24",@"key1"
                  ,@"未上架",@"key2"
                  ,@"明天上线，请耐心等待",@"key3"
                  ,@"颍州的孩子",@"key4"
                  ,@"Yingzhou children",@"key5"
                  ,@"这是第一部由华裔女导演拍摄的奥斯卡奖作品，影片讲述了三组艾滋孤儿的生活，希望通过今天的片子让大家了解到艾滋病病人在中国大地上正在怎样活着。上世纪90年代，河南等地因为卖血感染艾滋的悲剧今天依然在延续，我们同情、悲哀、愤怒；片中所关注的贫穷、愚昧、亲情、世态炎凉，更叫人心疼。",@"key6"
                  ,@"片长：78分钟",@"key7"
                  ,@"颍州的孩子",@"key8"
                  ,@"详情：",@"key9"
                  ,@"该片主要讲述了一个感染了艾滋病的小男孩高俊的真实的生活状态，父母因艾滋病去世，惟一与他相依为命的奶奶又相继“离开”，叔叔因怕别人的歧视而不愿收养他，最后在阜阳市艾滋病贫困儿童救助协会的帮助下走入艾滋家庭，在那里开始了他短暂而快乐的儿童生活，而随着艾滋病毒的恶化，又不得不让他再一次离开……中间不时穿插任楠楠、黄家三姐妹等因受艾滋病影响的孩子的生活，家庭的贫穷与无力，亲情的冷漠与无奈，周围人的歧视与无知，自己的恐惧与无助……最终在社会各界的大力帮助下，他们渐渐走出艾滋病魔的阴影，快乐、自信而坚强的。\r\n\r\n     该片的导演杨紫烨曾多次与国家卫生部合作策划制作艾滋病相关公益广告，其作品包括2004年的“姚明、魔术师约翰逊艾滋公益广告”以及“彭丽媛携手抗击艾滋，关爱儿童公益广告”等。",@"key10"
                  , nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.25",@"key1"
                  ,@"未上架",@"key2"
                  ,@"后天上线，请耐心等待",@"key3"
                  ,@"资本主义民主共和国",@"key4"
                  ,@"The people’s republic of capitalism",@"key5"
                  ,@"中国究竟是社会主义还是资本主义？Discovery频道通过镜头一探究竟。\r\n\r\n     有所不同。于是，“中国特色社会主义体系”在这部片子中便被诠释为“资本主义人民共和国”，镜头也试图通过资本大潮下中美两国的小人物们来折射资本主义的影响。",@"key6"
                  ,@"片长：56分钟",@"key7"
                  ,@"资本主义民主共和国",@"key8"
                  ,@"详情：",@"key9"
                  ,@"中国现有的两大突出阶层：日益壮大的新贵消费群体和数亿挣扎在生存线上的穷人。而他们也是中美资本链上关键的两环。高端人群消费从美国进口的商品，而很多商品则来自于美国设在中国的工厂，由庞大的中国廉价劳动力制造而成。以片中一个生动例子来说明：售价数千美金的品牌沙发，其木质零件由中国工人在本土制作，之后运回美国由本土工人完成组装、装饰和质检，最后再将成品出口到中国，被中国高端家庭购买。\r\n\r\n     在主持人看来，中国目前对全球经济做出的最大贡献就是提供廉价劳动力。美国工厂质检员的一小时薪酬20美元足够一位中国工厂质检员的周薪。更不用提中国庞大的农民工群体，相对种田的收益，他们外出打工每天挣几美元就已经知足了。美国的品牌，美国的创意，中国的廉价劳动力，中国的消费市场——这就是中国资本主义？至少影片折射出了这个意思。",@"key10"
                  , nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"12.26",@"key1"
                  ,@"未上架",@"key2"
                  ,@"后天上线，请耐心等待",@"key3"
                  ,@"工人炼狱",@"key4"
                  ,@"Workingman",@"key5"
                  ,@"这部影片是“全球化三部曲”之一，也是一部世纪性的工人诗篇。在这场惊人而沉重的历程中，展现了五个不同国家工人如何艰险地生存。死亡面前，他们令人肃然起敬。尽管这部片子有一个看起来很苦的名字（Workingman's Death），但重点却不是死，而是如何活着。这来自不同国家的几群工人举起沾着鲜血和油污的双手，在镜头前展现着他们艰苦的工作——看起来无法想到这是21世纪的工作。",@"key6"
                  ,@"片长：101分钟",@"key7"
                  ,@"工人炼狱",@"key8"
                  ,@"详情：",@"key9"
                  ,@"「这份工作本身就是死亡。死亡一直在我们身边围绕。我们必须克服恐惧，不然没办法做这个工作。」导演格拉沃格记录了地球上五个不同地点炼狱般的景象，让观众看到二十一世纪的今日，依然有劳工日复一日地在死亡与生命的交界处讨口饭吃。乌克兰的矿工非法潜入地层缝隙中挖煤。一不留神便可能被活埋在不见天日的地底下。印尼的搬运工从硫磺坑里用肉身扛起上百斤的重担，对观光客而言诡谲不似人间的壮景，对这些挑夫来说是确实散发着地狱气味的火坑。奈及利亚的露天屠宰场则是牛羊牲口通往炼狱的奈何桥，刀往脖子一抹腿一蹬，生命以最血淋淋的方式存在或消灭。但在后工业文明的德国，我们却看到退役的炼钢厂在夜里点上灯火，变成了另类的游乐园。前卫音乐大师约翰·佐恩的配乐更有画龙点睛之效。",@"key10"
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
    DCAboutViewController *about = [[DCAboutViewController alloc] initWithNibName:nil bundle:nil];
    about.hidesBottomBarWhenPushed = YES;
    double delayInSeconds = 0.258;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController pushViewController:about animated:YES];
    });
}

#pragma mark - movie
//  share
- (void)share
{
    
}

//  play
- (void)play
{
    DCMPMoviePlayerView*  mmpplayer = [[DCMPMoviePlayerView alloc] initWithNibName:nil bundle:nil];
    mmpplayer.hidesBottomBarWhenPushed = YES;
    //delay initial load so statusBarOrientation returns correct value
    double delayInSeconds = 0.258;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:mmpplayer animated:YES];
    });
}

- (void)pop
{
    
}

// download
- (void)download
{
    
}

// incommit
- (void)incommit
{
    
}


@end
