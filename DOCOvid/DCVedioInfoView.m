//
//  DCVedioInfoView.m
//  DOCOVedio
//
//  Created by amor on 13-12-12.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCVedioInfoView.h"
#import "DCShareView.h"
#import "DCDropAnimation.h"

@interface DCVedioInfoView()
{
    
    UIScrollView *scroller;//场景转换器
    
    //场景1
    UILabel *datelale;  //11.25
    UILabel *deslal;    //上架
    UILabel *detaillal; //明天上架，请耐心等待
    
    UIButton *questionBtn;//问号
    UIImageView *sepreate;//分割线图片

    UILabel *titlelal;  //听风的歌
    UILabel *english;   //Hear the wind Sing
    UITextView *longinfo;  //2006年夏天..
    UILabel *duraionTime;//片长时间
    
    //场景2
    UILabel *titlelal2;//第二个标题
    UILabel *descriptionlal;//详情
    UITextView *moreinfo;  //momo
    
    UIButton *dringbtn; //更多按钮
    UIButton *backbtn; //返回按钮
    UIButton *yuding; // 预定按钮
    UIButton *yiyuding; //取消预订按钮
    UIButton *shareBtn; //分享按钮
    UIButton *collectBtn; //收藏按钮
    
    
    UIImageView *visiable;//控制展开页面
}
@end

@implementation DCVedioInfoView
@synthesize dictory=_dictory;

#pragma mark - Action
- (void)expandInfo:(id)info
{
    questionBtn.selected = !questionBtn.selected;
    if (!visiable) {
        visiable = [[UIImageView alloc] initWithFrame:CGRectMake(40, 110, 190, 40)];
        visiable.image = [[UIImage imageNamed:@"span_str"] stretchableImageWithLeftCapWidth:2 topCapHeight:20];
        [self addSubview:visiable];
        
        UILabel *lal = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, 190, 20)];
        lal.text = @"收藏或者缓存能长期观看哦";
        lal.font = Cond_font(14);
        lal.textColor = [UIColor whiteColor];
        lal.backgroundColor = [UIColor clearColor];
        [visiable addSubview:lal];
        visiable.hidden = YES;
    }
    if (questionBtn.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            sepreate.frame = CGRectMake(33, 165, 234, 1);
        } completion:^(BOOL finished) {
            visiable.hidden = NO;
        }];
    }else{
         visiable.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
           sepreate.frame = CGRectMake(33, 120, 234, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void) moreInfo:(id)sender
{
    if (questionBtn.selected)
        visiable.hidden = YES;
    
    [scroller scrollRectToVisible:CGRectMake(self.width, 0, self.width, self.height) animated:YES];
    dringbtn.hidden = YES;
    backbtn.hidden = NO;
}

- (void) backInfo:(id)sender
{
    dringbtn.hidden = NO;
    backbtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [scroller scrollRectToVisible:CGRectMake(0, 0, self.width, self.height) animated:NO];
    } completion:^(BOOL finished) {
        if (questionBtn.selected)
            visiable.hidden = NO;
    }];
}

- (void) yudingAction:(id)sender
{
    yuding.hidden = YES;
    yiyuding.hidden = NO;
}

- (void) yiyudingAction:(id)sender
{
    yuding.hidden = NO;
    yiyuding.hidden = YES;
}

- (void) shareAction:(id)sender
{
    DCShareView *aler = [[[DCShareView alloc] init] DD_AUTORELEASE];
    [aler show];
}

- (void) collectAction:(id)sender
{
    collectBtn.selected = !collectBtn.selected;
    if (collectBtn.selected) {
        [DCDropAnimation animationDropWith:collectBtn  type:DCDropAnimationCollect];
    }else{
        [DCDropAnimation animationDeDropWith:collectBtn type:DCDropAnimationCollect];
    }
}

#pragma mark - layout
- (void)layoutSubviews1
{
    if (!scroller) {
        scroller = [[UIScrollView alloc] initWithFrame:self.bounds];
        scroller.contentSize = CGSizeMake(self.width*2, self.height);
        scroller.scrollEnabled = NO;
        [self addSubview:scroller];
    }
    
    if (!datelale) {
        datelale = [[UILabel alloc] initWithFrame:CGRectMake(30, 36, 100, 44)];
        datelale.backgroundColor = [UIColor clearColor];
        datelale.font = Cond_font(44.);
        datelale.text = @"11.15";
        datelale.textColor = [UIColor whiteColor];
        [scroller addSubview:datelale];
    }
    
    if (!deslal) {
        deslal = [[UILabel alloc] initWithFrame:CGRectMake(130, 42, 100, 35)];
        deslal.backgroundColor = [UIColor clearColor];
        deslal.font = Cond_font(30.);
        deslal.text = @"上架";
        deslal.textColor = [UIColor whiteColor];
        [scroller addSubview:deslal];
    }
    
    if (!detaillal) {
        detaillal = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 240, 35)];
        detaillal.backgroundColor = [UIColor clearColor];
        detaillal.font = Bold_font(14.);
        detaillal.text = @" 公放期：你还有三天";
        detaillal.textColor = [UIColor whiteColor];
        [scroller addSubview:detaillal];
    }
    
    if (!questionBtn) {
        questionBtn = [[UIButton alloc] initWithFrame:CGRectMake(190, 78, 38, 38)];
        [questionBtn setImage:[UIImage imageNamed:@"ques_btn_n"] forState:UIControlStateNormal];
        [questionBtn setImage:[UIImage imageNamed:@"ques_btn_h"] forState:UIControlStateSelected];
        [questionBtn setImage:[UIImage imageNamed:@"ques_btn_h"] forState:UIControlStateHighlighted];
        [questionBtn addTarget:self action:@selector(expandInfo:) forControlEvents:UIControlEventTouchUpInside];
        [scroller addSubview:questionBtn];
    }
    
    if (!sepreate) {
        sepreate = [[UIImageView alloc] initWithFrame:CGRectMake(33, 120, 234, 1)];
        sepreate.image = [UIImage imageNamed:@"sepreate_img"];
        [scroller addSubview:sepreate];
    }
    if (!titlelal) {
        titlelal = [[UILabel alloc] initWithFrame:CGRectMake(26, 170, 240, 35)];
        titlelal.backgroundColor = [UIColor clearColor];
        titlelal.font = Cond_font(30.);
        titlelal.text = @" 听风的歌";
        titlelal.textColor = [UIColor whiteColor];
        [scroller addSubview:titlelal];
    }
    
    if (!english) {
        english = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 240, 35)];
        english.backgroundColor = [UIColor clearColor];
        english.font = EuphBold_font(18.);
        english.text = @" Hear the Wind Sing";
        english.textColor = [UIColor whiteColor];
        [scroller addSubview:english];
    }
    
    if (!longinfo) {
        longinfo = [[UITextView alloc] initWithFrame:CGRectMake(30, 240, 240, 266)];
        longinfo.backgroundColor = [UIColor clearColor];
        longinfo.font = Medium_font(14.);
        longinfo.textColor = [UIColor whiteColor];
        longinfo.editable = NO;
        longinfo.showsVerticalScrollIndicator = NO;
        longinfo.text = @"     2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。";
        [scroller addSubview:longinfo];
    }
    
    if (!duraionTime) {
        duraionTime = [[UILabel  alloc] initWithFrame:CGRectMake(30, 524, 240, 30)];
        duraionTime.backgroundColor = [UIColor clearColor];
        duraionTime.font = EuphBold_font(20.);
        duraionTime.text = @" 片长：88分钟";
        duraionTime.textColor = [UIColor whiteColor];
        [scroller addSubview:duraionTime];
    }
    
    
    if (!titlelal2) {
        titlelal2 = [[UILabel alloc] initWithFrame:CGRectMake(26+self.width, 40, 240, 35)];
        titlelal2.backgroundColor = [UIColor clearColor];
        titlelal2.font = Cond_font(30.);
        titlelal2.text = @" 听风的歌";
        titlelal2.textColor = [UIColor whiteColor];
        [scroller addSubview:titlelal2];
    }
    
    if (!descriptionlal) {
        descriptionlal = [[UILabel alloc] initWithFrame:CGRectMake(30+self.width, 76, 240, 35)];
        descriptionlal.backgroundColor = [UIColor clearColor];
        descriptionlal.font = Cond_font(20.);
        descriptionlal.text = @" 详情：";
        descriptionlal.textColor = [UIColor whiteColor];
        [scroller addSubview:descriptionlal];
    }
    
    if (!moreinfo) {
        moreinfo = [[UITextView alloc] initWithFrame:CGRectMake(30+self.width, 120, 240, 400)];
        moreinfo.backgroundColor = [UIColor clearColor];
        moreinfo.font = Medium_font(14.);
        moreinfo.textColor = [UIColor whiteColor];
        moreinfo.editable = NO;
        moreinfo.showsVerticalScrollIndicator = NO;
        moreinfo.text = @"     2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。";
        [scroller addSubview:moreinfo];
    }
    
    if (!dringbtn) {
        dringbtn = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(50, 560, 120, 40)];
        dringbtn.frame = CGRectMake(38, 575, 92, 30);
        [dringbtn setImage:[UIImage imageNamed:@"more_btn_n"] forState:UIControlStateNormal];
        [dringbtn setImage:[UIImage imageNamed:@"more_btn_h"] forState:UIControlStateSelected];
        [dringbtn setImage:[UIImage imageNamed:@"more_btn_h"] forState:UIControlStateHighlighted];
        [dringbtn addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dringbtn];
    }
    
    
    if (!backbtn) {
        backbtn = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(50, 560, 120, 40)];
        backbtn.frame = CGRectMake(38, 575, 92, 30);
        backbtn.hidden = YES;
        [backbtn setTitle:@"返  回" forState:UIControlStateNormal];
        [backbtn.titleLabel setFont:Euph_font(15)];
        [backbtn setBackgroundImage:[UIImage imageNamed:@"nm_btn_n"] forState:UIControlStateNormal];
        [backbtn setBackgroundImage:[UIImage imageNamed:@"nm_btn_h"] forState:UIControlStateSelected];
        [backbtn setBackgroundImage:[UIImage imageNamed:@"nm_btn_h"] forState:UIControlStateHighlighted];
        [backbtn addTarget:self action:@selector(backInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backbtn];
    }
    
    if (!shareBtn) {
        shareBtn = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(200, 560, 80, 40)];
        shareBtn.frame = CGRectMake(176, 569, 42, 42);
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_n"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_h"] forState:UIControlStateSelected];
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_h"] forState:UIControlStateHighlighted];
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }
    
    if (!collectBtn) {
        collectBtn = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(200, 560, 80, 40)];
        collectBtn.frame = CGRectMake(222, 569, 42, 42);
        [collectBtn setImage:[UIImage imageNamed:@"collect_btn_n"] forState:UIControlStateNormal];
        [collectBtn setImage:[UIImage imageNamed:@"collect_btn_h"] forState:UIControlStateSelected];
        [collectBtn setImage:[UIImage imageNamed:@"collect_btn_h"] forState:UIControlStateHighlighted];
        [collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collectBtn];
    }
}

- (void)layoutSubviews2
{
    if (!scroller) {
        scroller = [[UIScrollView alloc] initWithFrame:self.bounds];
        scroller.contentSize = CGSizeMake(self.width*2, self.height);
        scroller.scrollEnabled = NO;
        [self addSubview:scroller];
    }
    
    if (!datelale) {
        datelale = [[UILabel alloc] initWithFrame:CGRectMake(30, 36, 100, 44)];
        datelale.backgroundColor = [UIColor clearColor];
        datelale.font = Cond_font(44.);
        datelale.text = @"11.15";
        datelale.textColor = [UIColor whiteColor];
        [scroller addSubview:datelale];
    }
    
    if (!deslal) {
        deslal = [[UILabel alloc] initWithFrame:CGRectMake(130, 42, 100, 35)];
        deslal.backgroundColor = [UIColor clearColor];
        deslal.font = Cond_font(30.);
        deslal.text = @"上架";
        deslal.textColor = [UIColor whiteColor];
        [scroller addSubview:deslal];
    }
    
    if (!detaillal) {
        detaillal = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 240, 35)];
        detaillal.backgroundColor = [UIColor clearColor];
        detaillal.font = Bold_font(14.);
        detaillal.text = @" 明天上线，请耐心等待";
        detaillal.textColor = [UIColor whiteColor];
        [scroller addSubview:detaillal];
    }

    if (!sepreate) {
        sepreate = [[UIImageView alloc] initWithFrame:CGRectMake(33, 120, 234, 1)];
        sepreate.image = [UIImage imageNamed:@"sepreate_img"];
        [scroller addSubview:sepreate];
    }
    if (!titlelal) {
        titlelal = [[UILabel alloc] initWithFrame:CGRectMake(26, 170, 240, 35)];
        titlelal.backgroundColor = [UIColor clearColor];
        titlelal.font = Cond_font(30.);
        titlelal.text = @" 听风的歌";
        titlelal.textColor = [UIColor whiteColor];
        [scroller addSubview:titlelal];
    }
    
    if (!english) {
        english = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 240, 35)];
        english.backgroundColor = [UIColor clearColor];
        english.font = EuphBold_font(18.);
        english.text = @" Hear the Wind Sing";
        english.textColor = [UIColor whiteColor];
        [scroller addSubview:english];
    }
    
    if (!longinfo) {
        longinfo = [[UITextView alloc] initWithFrame:CGRectMake(30, 240, 240, 300)];
        longinfo.backgroundColor = [UIColor clearColor];
        longinfo.font = Medium_font(14.);
        longinfo.textColor = [UIColor whiteColor];
        longinfo.editable = NO;
        longinfo.showsVerticalScrollIndicator = NO;
        longinfo.text = @"     2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。";
        [scroller addSubview:longinfo];
    }
    
    
    if (!titlelal2) {
        titlelal2 = [[UILabel alloc] initWithFrame:CGRectMake(26+self.width, 40, 240, 35)];
        titlelal2.backgroundColor = [UIColor clearColor];
        titlelal2.font = Cond_font(30.);
        titlelal2.text = @" 听风的歌";
        titlelal2.textColor = [UIColor whiteColor];
        [scroller addSubview:titlelal2];
    }
    
    if (!descriptionlal) {
        descriptionlal = [[UILabel alloc] initWithFrame:CGRectMake(30+self.width, 76, 240, 35)];
        descriptionlal.backgroundColor = [UIColor clearColor];
        descriptionlal.font = Cond_font(20.);
        descriptionlal.text = @" 详情：";
        descriptionlal.textColor = [UIColor whiteColor];
        [scroller addSubview:descriptionlal];
    }
    
    if (!moreinfo) {
        moreinfo = [[UITextView alloc] initWithFrame:CGRectMake(30+self.width, 120, 240, 400)];
        moreinfo.backgroundColor = [UIColor clearColor];
        moreinfo.font = Medium_font(14.);
        moreinfo.textColor = [UIColor whiteColor];
        moreinfo.editable = NO;
        moreinfo.showsVerticalScrollIndicator = NO;
        moreinfo.text = @"     2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。2006年夏天，冰岛知名乐园Sigur Ros结束了为期一年的世界巡回，决定在家乡举办一系列免费演出，不论是教堂、废弃工厂、小市镇的表演厅或者空旷无人的荒野寂寞，Sigur Ros用绝美乐音将自身放逐于冰岛边疆，迷人音符衬着蓝天、绿地、白雪和灰墙，成了乐迷珍藏的心灵风暴。本片是Sigur Ros首部官方电影，交织表演实况与团员访谈，纪录了令人动容的归乡旅程。";
        [scroller addSubview:moreinfo];
    }
    
    if (!yuding) {
        yuding = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(50, 560, 120, 40)];
        yuding.frame = CGRectMake(38, 575, 92, 30);
        [yuding setTitle:@"预   定" forState:UIControlStateNormal];
        [yuding.titleLabel setFont:Euph_font(15)];
        [yuding setBackgroundImage:[UIImage imageNamed:@"nm_btn_n"] forState:UIControlStateNormal];
        [yuding setBackgroundImage:[UIImage imageNamed:@"nm_btn_h"] forState:UIControlStateSelected];
        [yuding setBackgroundImage:[UIImage imageNamed:@"nm_btn_h"] forState:UIControlStateHighlighted];
        [yuding addTarget:self action:@selector(yudingAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yuding];
    }
    
    
    if (!yiyuding) {
        yiyuding = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(50, 560, 120, 40)];
        yiyuding.frame = CGRectMake(38, 575, 92, 30);
        yiyuding.hidden = YES;
        [yiyuding setTitle:@"取消预定" forState:UIControlStateNormal];
        [yiyuding.titleLabel setFont:Euph_font(15)];
        [yiyuding setBackgroundImage:[UIImage imageNamed:@"hl_btn_n"] forState:UIControlStateNormal];
        [yiyuding setBackgroundImage:[UIImage imageNamed:@"hl_btn_h"] forState:UIControlStateSelected];
        [yiyuding setBackgroundImage:[UIImage imageNamed:@"hl_btn_h"] forState:UIControlStateHighlighted];
        [yiyuding addTarget:self action:@selector(yiyudingAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yiyuding];
    }
    
    if (!shareBtn) {
        shareBtn = [[UIButton alloc] init];//[[UIButton alloc] initWithFrame:CGRectMake(200, 560, 80, 40)];
        shareBtn.frame = CGRectMake(176, 569, 42, 42);
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_n"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_h"] forState:UIControlStateSelected];
        [shareBtn setImage:[UIImage imageNamed:@"share_btn_h"] forState:UIControlStateHighlighted];
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }
}

#pragma mark - DCVedioInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.infoViewStyle = VedioInfoViewTypeLast;
    }
    return self;
}

- (void)revalInfo
{
    datelale.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key1"]];
    deslal.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key2"]];
    detaillal.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key3"]];
    titlelal.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key4"]];
    english.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key5"]];
    longinfo.text = [NSString stringWithFormat:@"     %@",[_dictory objectForKey:@"key6"]];
    duraionTime.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key7"]];
    titlelal2.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key8"]];
    descriptionlal.text = [NSString stringWithFormat:@"%@",[_dictory objectForKey:@"key9"]];
    moreinfo.text = [NSString stringWithFormat:@"     %@",[_dictory objectForKey:@"key10"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.infoViewStyle) {
        case VedioInfoViewTypeLast:
            [self layoutSubviews1];
            break;
        case VedioInfoViewTypeNews:
            [self layoutSubviews2];
            break;
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
