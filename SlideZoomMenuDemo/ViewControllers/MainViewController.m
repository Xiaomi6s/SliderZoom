//
//  MainViewController.m
//  SlideZoomMenuDemo
//
//  Created by renxiaojian on 15/4/8.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"
#import "NextViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSArray *dataSoruce;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的会员";
    self.dataSoruce = @[@{@"image":@"mm1",@"name":@"网络的",@"detail":@"网络的美女太多了吧"},
                        @{@"image":@"mm2",@"name":@"古典的",@"detail":@"中国古代十大美女，包括妇孺皆知的古代四大美女，沉鱼的西施、闭月的貂蝉、落雁的王昭君、羞花的杨贵妃。另外六位分别是集三千宠爱于一身的冯小怜、一代妖姬苏妲己、命运凄惨的赵飞燕、与西施比美的郑旦、千金一笑的褒姒、因《洛神赋》被传为“洛神”的甄氏（甄宓）"},
                        @{@"image":@"mm3",@"name":@"清纯的",@"detail":@"西施浣纱西施，名夷光，春秋战国时期出生于浙江诸暨苎萝村。天生丽质，五官端正，粉面桃花，相貌过人。时越国称臣於吴国，越王勾践卧薪尝胆，谋复国。在国难当头之际，西施忍辱负重，以身许国，与郑旦一起由越王勾践献给吴王夫差，成为吴王最宠爱的妃子。把吴王迷惑得众叛亲离，无心国事，为勾践的东山再起起了掩护的作用。表现了一个爱国女子的高尚思想情操。后吴国终被勾践所灭。吴被灭后，越王勾践班师回朝，携西施以归。越王勾践的夫人潜使人引出，负以大石沉于江中，曰：“此亡国之物，留之何用？”后人不知其事，讹传与范蠡泛舟五湖，不知所终。遂有“载去西施岂无意？恐留倾国误君王”之句。又有言范蠡恐越王复迷其色，乃以计沉于江中，此是错误的说法。"},
                        @{@"image":@"mm4",@"name":@"可爱的",@"detail":@"昭君画像王嫱，号昭君，南郡秭归（今湖北省兴山县）人。汉元帝时以“良家子”入选掖庭的。时，呼韩邪来朝，帝敕以五女赐之。王昭君入宫数年，不得见御，积悲怨，乃请掖庭令求行。呼韩邪临辞大会，帝召五女以示之。昭君亦有风华绝代之容，倾国倾城之貌，光明汉宫，顾影徘徊，竦动左右。帝见大惊，意欲留之，而难于失信，遂与匈奴。昭君出塞后，汉匈两族团结和睦，国泰民安。公元前31年，呼韩邪单于亡故，留下一子，名伊屠智伢师，后为匈奴右日逐王。时，王昭君以大局为重，忍受极大委屈，按照匈奴“父死，妻其后母”的风俗，嫁给呼韩邪的长子复株累单于雕陶莫皋。王昭君的历史功绩，不仅仅是她主动出塞和亲，更主要的是她出塞之后，使汉朝与匈奴和好，边塞的烽烟熄灭了50年，增强了汉族与匈奴民族之间的民族团结，是符合汉族和匈奴族人民的利益的。她与她的子女后孙以及姻亲们对胡汉两族人民和睦亲善与团结做出了巨大贡献，因此，她得到历史的好评。元代诗人赵介认为王昭君的功劳，不亚于汉朝名将霍去病。昭君的故事，成为我国历史上流传不衰的民族团结的佳话。红颜薄命，昭君年仅33岁就香消玉损，离开人世。"},
                        @{@"image":@"mm5",@"name":@"性感的",@"detail":@"貂蝉画像貂蝉，在关汉卿的剧本里记载此女名为任红昌，山西并州(今忻州)人。是东汉末年司徒王允的歌女，国色天香，有倾国倾城之貌。见东汉王朝被奸臣董卓所操纵，於月下焚香祷告上天，愿为主人担忧。王允眼看董卓将篡夺东汉王朝，设下连环计。王允先把貂蝉暗地里许给吕布，在明把貂蝉献给董卓。吕布英雄年少，董卓老奸巨猾。为了拉拢吕布，董卓收吕布为义子。二人都是好色之人。从此以后，貂蝉周旋於此二人之间，送吕布於秋波，报董卓於妩媚，把二人撩拨得神魂颠倒。吕布自董卓收貂蝉入府为姬之后，心怀不满。王允便说服吕布，铲除了董卓，而貂蝉也跟随了吕布。吕布死后貂蝉不知所踪，罗贯中在《三国演义》里只有两个人物没有记载去向，其中就有貂蝉。而根据我对三国的研究，我认为貂蝉最终是跟随了曹操，而关羽之所以后来又反叛曹操投奔刘备，就和貂蝉有关。"},
                        @{@"image":@"mm6",@"name":@"女神",@"detail":@"杨贵妃画像杨贵妃，原名杨玉环，唐代蒲州永乐人(山西永济人)。通晓音律，能歌善舞。最初为唐玄宗的第十八子寿王的王妃，唐玄宗见杨玉环的姿色后，欲纳入宫中为女道士，号太真。天宝四年入宫，得唐玄宗宠幸，封为贵妃父兄均因此而得以势倾天下。贵妃每次乘马，都有大宦官高力士亲至执鞭，贵妃的织绣工就有七百人，更有争献珍玩者。岭南经略史张九章，广陵长史王翼，因所献精美，二人均被升官。于是，百官竟相仿效。杨贵妃喜爱岭南荔枝，就有人千方百计急运新鲜荔枝到长安。后安史之乱，唐玄宗逃离长安，途至马嵬坡，六军不肯前行，说是因为杨国忠(贵妃之堂兄)通于胡人，而致有安禄山之反，玄宗为息军心，乃杀杨国忠。六军又不肯前行，谓杨国忠为贵妃堂兄，堂兄有罪，堂妹亦难免，贵妃亦被缢死于路祠。安史之乱与杨贵妃无关，她成了唐玄宗的替罪羔羊。"}];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainCell" bundle:nil] forCellReuseIdentifier:@"MainCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoruce.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    cell.imgView.image = [UIImage imageNamed:[self.dataSoruce[indexPath.row] objectForKey:@"image"]];
    cell.text.text = [self.dataSoruce[indexPath.row] objectForKey:@"name"];
    cell.detail.text = [self.dataSoruce[indexPath.row] objectForKey:@"detail"];
    [cell.contentView layoutIfNeeded];
    [cell.contentView updateConstraintsIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    cell.imgView.image = [UIImage imageNamed:[self.dataSoruce[indexPath.row] objectForKey:@"image"]];
    cell.text.text = [self.dataSoruce[indexPath.row] objectForKey:@"name"];
    cell.detail.text = [self.dataSoruce[indexPath.row] objectForKey:@"detail"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextViewController *nextVC = [NextViewController new];
    [self.navigationController pushViewController:nextVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
