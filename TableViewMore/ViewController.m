//
//  ViewController.m
//  TableViewMore
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "attTableViewCell.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

{
    NSMutableArray *newdataslit;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nnib.
   
    
    newdataslit = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *firse = [NSString stringWithFormat:@"%d",i];
        NSString *messgea = [NSString stringWithFormat:@"表示图%d详情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈情展示，哈哈哈啊哈哈",i];
        NSLog(@"asdjsajdsadjsadjsa");
         NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjects:@[firse,messgea] forKeys:@[@"title",@"message"]];
        [newdataslit addObject:dic1];

    }
    
    for (NSMutableDictionary *dic in newdataslit) {
        [dic setValue:@"NO" forKey:@"ISOPEN"];
        [dic setValue:@"MainCell" forKey:@"cell"];
    };
    
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newdataslit.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([newdataslit[indexPath.row][@"cell"] isEqualToString:@"AttachedCell"]) {
        return 150;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[newdataslit[indexPath.row] objectForKey:@"cell"] isEqualToString:@"MainCell"]) {
        static NSString *idnet = @"ident";
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idnet];
        if (cell == nil) {
            cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idnet];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        cell.label1.text = [newdataslit[indexPath.row] objectForKey:@"title"];
        return cell;
    } else if ([[newdataslit[indexPath.row] objectForKey:@"cell"] isEqualToString:@"AttachedCell"]){
        static NSString *idneted = @"idented";
        attTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idneted];
        if (cell == nil) {
            cell = [[attTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idneted];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        cell.label.text = [newdataslit[indexPath.row] objectForKey:@"message"];
        return cell;
    }
    return nil;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *path = nil;
    
    if ([newdataslit[indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:0];
    } else {
        path = indexPath;
        NSLog(@"点击了附加的标");
    }
    NSString *name = newdataslit[path.row][@"title"];
    NSString *message = newdataslit[path.row][@"message"];
    
    if ([[newdataslit[indexPath.row] objectForKey:@"ISOPEN"] boolValue]) {
       
        //关闭附加的cell
     
        NSMutableDictionary *nameAndState = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",name,@"title",@"NO",@"ISOPEN",message,@"message", nil];
        newdataslit[path.row - 1] = nameAndState;
        
        [newdataslit removeObjectAtIndex:path.row];
        NSLog(@"%@", newdataslit[indexPath.row - 1]);
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
    } else {
        NSMutableDictionary *nameAndState = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",name,@"title",@"YES",@"ISOPEN",message,@"message", nil];
        newdataslit[path.row - 1] = nameAndState;
        NSMutableDictionary *nameState = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AttachedCell",@"cell",@"YES",name,@"title",@"ISOPEN",message,@"message" ,nil];
        [newdataslit insertObject:nameState atIndex:path.row];
        
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
        NSLog(@"开启：%@", newdataslit[indexPath.row]);

    }
    
  
}




















@end
