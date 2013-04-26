//
//  CarViewController.m
//  TrafficQuery
//
//  Created by han zhen on 13-3-29.
//  Copyright (c) 2013年 hz. All rights reserved.
//
//通过调用表格的reloadData方法，表格开始查询其数据源加载内容。
#import "CarViewController.h"
#import "HomeIntroduce.h"
#import "ModifyViewController.h"



// Define one of the following macros to 1 to control which type of cell will be used.
#define USE_INDIVIDUAL_SUBVIEWS_CELL    1	// use a xib file defining the cell
#define USE_COMPOSITE_SUBVIEW_CELL      0	// use a single view to draw all the content
#define USE_HYBRID_CELL                 0	// use a single view to draw most of the content + separate label to render the rest of the content


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]

#define BARBUTTON(TITLE, SELECTOR) [[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStyleBordered target:self action:SELECTOR] autorelease]


@implementation CarViewController

@synthesize tmpCell, data, cellNib;
@synthesize delegate;
@synthesize modifyDelegate;


#pragma mark -
#pragma mark View controller methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
	self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
	
	// Configure the table view.
    self.tableView.rowHeight = 73.0;
    self.tableView.backgroundColor = DARK_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.data = [[NSArray alloc] initWithArray:[self carNum]];

	self.cellNib = [UINib nibWithNibName:@"CarCell" bundle:nil];
}


- (void)viewDidUnload
{
	[super viewDidLoad];
	
	self.data = nil;
	self.tmpCell = nil;
	self.cellNib = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark Table view methods
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return character;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [character objectAtIndex:section];
}



//转值调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row=[indexPath row];
    NSUInteger section=[indexPath section];
    
    
    
    NSLog(@"row = %d",row);
    NSLog(@"%@",[dictionary1[section] objectAtIndex:row]);
    
    NSString *name=[[self.data objectAtIndex:1]objectForKey:[(dictionary1[section]) objectAtIndex:row]];
    NSLog(@"name = %@",name);

    
    self.delegate.iconNumStr = [NSString stringWithFormat:@"%@.jpg",name];
    self.delegate.iconImageView.image = [UIImage imageNamed:self.delegate.iconNumStr];

    self.delegate.carNameStr = [dictionary1[section] objectAtIndex:row];
    
    self.delegate.selectIconLabel.text = self.delegate.carNameStr;
    
    
    //////////////////////////////////////////////
    self.modifyDelegate.carImageStr = [NSString stringWithFormat:@"%@.jpg",name];
    self.modifyDelegate.carPaiImageView.image = [UIImage imageNamed:self.modifyDelegate.carImageStr];
    self.modifyDelegate.carNameStr = [dictionary1[section] objectAtIndex:row];
    self.modifyDelegate.carNameLabel.text = self.modifyDelegate.carNameStr;
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 1;
    return   [character count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [data count];
  // return [[self.data objectAtIndex:0] count];
    return [(dictionary1[section]) count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ApplicationCell";
    
    CarBaseCell *cell = (CarBaseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
#if USE_INDIVIDUAL_SUBVIEWS_CELL
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
		
#elif USE_COMPOSITE_SUBVIEW_CELL
        //cell = [[[CompositeSubviewBasedApplicationCell alloc] initWithStyle: UITableViewCellS]]
        cell = [[[CompositeSubviewBasedApplicationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:CellIdentifier] autorelease];
		
#elif USE_HYBRID_CELL
        cell = [[[HybridSubviewBasedApplicationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:CellIdentifier] autorelease];
#endif
    }
    
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    
    NSUInteger section1 = [indexPath section];
    

    NSUInteger row = [indexPath row];//第几行
 //   NSLog(@"row= %d",row);
    //汽车名字
   // NSString* sshouzimu = [[self.data objectAtIndex:0] objectAtIndex:row];
    NSString* ABC = [(dictionary1[section1]) objectAtIndex:row];
   // NSLog(@"ABC == %@",ABC);
    cell.carName = ABC;
    
   // cell.carName = sshouzimu;
    //汽车图片
  //-  cell.carImage =[self carImgae:[[self.data objectAtIndex:1] objectForKey:sshouzimu]];
  cell.carImage = [self carImgae:[[self.data objectAtIndex:1] objectForKey:ABC]];
    
    

	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((CarBaseCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [data release];
	[tmpCell release];
	[cellNib release];
	
    [super dealloc];
}
////////////////////////////
- (UITableViewStyle)tableViewStyle
{
	return UITableViewStylePlain;
};


//图片名字
-(NSArray *)carNum
{
    NSBundle *bundle=[NSBundle mainBundle];
    
    NSString *fileName=[bundle pathForResource:[NSString stringWithFormat:@"brand_name"] ofType:@"txt"];
    
    NSString *pageSource=[[NSString alloc]initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *lines=[pageSource componentsSeparatedByString:@"\n"];//每一辆车为一个数组
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:[lines count]];
    
    
    for(int i = 0; i <= 19;i++){
        dictionary1[i] = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *arr1=[NSMutableArray arrayWithObjects: nil];
    // 首字母
    //取首字
    character=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"F",@"J",@"H",@"K",@"L",@"M",@"N",@"O",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
    for(NSString *line in lines){
        
        NSArray *arr=[line componentsSeparatedByString:@":"];
      //  NSLog(@"arr[1] = %@", [arr objectAtIndex:0]);
        
        [arr1 addObject:[arr objectAtIndex:1]];//B:保时捷:19，取中文名字,0, 1, 2
        for (int i=0; i<=19; i++) {
            
            
         //   NSLog(@"[arr objectAtIndex:%@]",[[arr objectAtIndex:0] class]);
            if ([[arr objectAtIndex:0]  isEqualToString:[character objectAtIndex:i]]) {
                //NSLog(@"%@",[dictionary[i] class]);
                [(dictionary1[i]) addObject:[arr objectAtIndex:1] ];
               // NSLog(@"[arr objetcAtIndex:1]==%@",[arr objectAtIndex:1]);
              //  NSLog(@"dictionary[%d] = %@",i,dictionary1[i]);
                
                
                break;
            }
            
        }

        
        [dic setValue:[[arr objectAtIndex:2] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:[arr objectAtIndex:1]];
        //数字去
        [[arr objectAtIndex:2] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除空格和换行符
    }
    
    NSString *carnum;
    
    carnum=[dic objectForKey:@"宝马"];
    
    NSMutableArray *arr2=[NSMutableArray arrayWithObjects:arr1,dic, nil];
    
    return arr2;
    
}
//汽车图片
-(UIImage *)carImgae:(NSString *)carnum
{
    NSString *name=[[NSString alloc]initWithFormat:@"%@.jpg",carnum ];
    UIImage *carimage=[UIImage imageNamed:name];
    [name release];
    return carimage;
}

@end
