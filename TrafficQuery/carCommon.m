//
//  carCommon.m
//  TrafficQuery
//
//  Created by hz on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "carCommon.h"
//#import "IndexCarCell.h"
#import "IndexViewController.h"
#import "ModifyCell.h"
#import "ModifyViewController.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]
@interface carCommon ()

@end

@implementation carCommon
@synthesize carDictionary;
@synthesize mainTableView;
@synthesize carMutableArray;
@synthesize deleteButton;


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
    // Do any additional setup after loading the view from its nib.
    [self initMainTableView];
}
-(void)initMainTableView{
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
    NSLog(@"self.carMutableArray = %@", self.carMutableArray);

}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell* cell;
   
        cell = (ModifyCell*)[tableView dequeueReusableCellWithIdentifier:@"ModifyCell"];
    
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ModifyCell" owner:self options:nil] lastObject];
        }
        NSString* tempImageStr;
        NSString* tempCarNumStr;
        NSString* tempCarJiaStr;
        self.carDictionary = [self.carMutableArray objectAtIndex:indexPath.row];

        // tempCarNumStr = [[self.carDictionary allKeys] objectAtIndex:indexPath.row];
       tempCarNumStr = [[self.carDictionary objectForKey:@"carNum"] uppercaseString];
       NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
       [yu appendString:tempCarNumStr];
        ((ModifyCell*)cell).carPaiLabel.text = yu;
    
        tempCarJiaStr = [self.carDictionary objectForKey:@"carJiaNum"];
        ((ModifyCell*)cell).carJiaLabelHidden.text = tempCarJiaStr;
    
        ((ModifyCell*)cell).carJiaLabelHidden.hidden = YES;
    
        tempImageStr = [self.carDictionary objectForKey:@"carImageNum"];
        ((ModifyCell*)cell).carBiaoImageView.image = [UIImage imageNamed:tempImageStr];
        ((ModifyCell*)cell).commonDelegate = self;
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_more_item_middle.png"]];

    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* tempImageStr;
    NSString* tempCarNumStr;
    NSString* tempCarJiaStr;
    self.carDictionary = [self.carMutableArray objectAtIndex:indexPath.row];
    tempCarNumStr = [[self.carDictionary objectForKey:@"carNum"] uppercaseString];
    NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
    [yu appendString:tempCarNumStr];
    tempCarJiaStr = [self.carDictionary objectForKey:@"carJiaNum"];
    tempImageStr = [self.carDictionary objectForKey:@"carImageNum"];
    [self showModifyVC:yu carJia:tempCarJiaStr];
    
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 65.0f;
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{

    return [[NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH] count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)deleteCar:(UIButton*)sender{
    if(sender.tag == 18){
        [self.mainTableView setEditing:YES animated:YES];
        deleteButton.tag = 05;
    }else{
        [self.mainTableView setEditing:NO animated:YES];
        deleteButton.tag = 18;
    }
    
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.carMutableArray removeObjectAtIndex:indexPath.row];
    [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
    [mainTableView reloadData];
}

-(IBAction)goBack:(UIButton *)sender{
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}
//有改动
-(void)dealloc{
    [carMutableArray release];
    [carDictionary release];
    [indexViewController release];
    [ModifyViewController release];
    [super dealloc];
}
-(void)showModifyVC:(NSString*)carPaiStr carJia:(NSString*)carJiaStr{
    
    modifyViewController = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    modifyViewController.carPaiStr = carPaiStr;
    
    NSLog(@"carPaiTextField.text = %@",carPaiStr);
    modifyViewController.carJiaStr = carJiaStr;
    int num = [self.carMutableArray count];
    for(int i = 0; i < num; i++)
    {
        NSString* tempCarJia = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carJiaNum"];
        if([carJiaStr isEqualToString:tempCarJia])
        {
            
            modifyViewController.carImageStr = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carImageNum"];
            modifyViewController.carNameStr = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carImage"];

        }
    }
    [self.navigationController pushViewController:modifyViewController animated:YES];
    
}


@end
