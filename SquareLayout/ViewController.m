//
//  ViewController.m
//  SquareLayout
//
//  Created by yxhe on 16/5/10.
//  Copyright © 2016年 yxhe. All rights reserved.
//

#import "ViewController.h"

#define TOP_MARGIN 50

const int square_count = 13; //we only have 13 logos, so this variable must < 13
const int col_count = 4;
const int block_space = 4;

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *squareData; //the squares' title and logo

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //parse the json file
    NSString* path = [[NSBundle mainBundle] pathForResource:@"LifeService" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error;
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonObj || error)
        NSLog(@"JSON parse failed!");
    
    self.squareData = [jsonObj objectForKey:@"Record"];
    
    //set view background color
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //setup the square layout
    for(int i = 0; i < square_count; i++)
    {
        //comput the row and col index
        int row = i/col_count;
        int col = i%col_count;
        
        //comput the size and position
        float block_size = (self.view.frame.size.width - block_space*col_count)/col_count;
        float x = block_space/2 + col*(block_size + block_space);
        float y = TOP_MARGIN + block_space/2 + row*(block_size + block_space);
        
//        NSLog(@"%f %f", x, y);
        
        UIView *block = [[UIView alloc] init];
        block.frame = CGRectMake(x, y, block_size, block_size);
        block.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, block_size, block_size);
        
        //set button image
        [button setImage:[UIImage imageNamed:[self.squareData[i] objectForKey:@"imgLogo"]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //set button title
        [button setTitle:[self.squareData[i] objectForKey:@"title"] forState:UIControlStateNormal];
//        [button setBackgroundColor:[UIColor greenColor]];

        [block addSubview:button];
        
        //add the button to the block
        [self.view addSubview:block];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//button callback
- (void)onClick:(UIButton *)button
{
    NSLog(@"%@ clicked", button.currentTitle);
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"message"
                                                       message:[NSString stringWithFormat:@"%@ clicked", button.currentTitle]
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil];
    [alerView show];
}

@end
