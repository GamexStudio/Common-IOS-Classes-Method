//
//  HomeViewController.m
//  RPG
//
//  Created by Ashish Chauhan on 04/04/16.
//  Copyright © 2016 Ashish Chauhan. All rights reserved.
//

#import "HomeViewController.h"
#import "MydietViewController.h"
#import "MykidnycareViewController.h"
#import "SearchForClinicViewController.h"
#import "AboutCKDViewController.h"
#import "MyGroupViewController.h"



@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.leftItemsSupplementBackButton = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self addGestureRecogniser:self.mydiet_view];
    [self addGestureRecogniser:self.mychat_view];
    [self addGestureRecogniser:self.mygroup_view];
    [self addGestureRecogniser:self.mykidnykare_view];
    [self addGestureRecogniser:self.mysearchforclinic_view];
    [self addGestureRecogniser:self.aboutckd_view];
    
    
}


-(void)addGestureRecogniser:(UIView *)touchView{
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapperHandler:)];
    [touchView addGestureRecognizer:singleTap];
    NSLog(@"ADD GESTURE RECOGNIZER");
}
-(void)TapperHandler:(id)sender {
    
    // do something
    NSInteger the_tag = [(UIGestureRecognizer *)sender view].tag;

    NSLog(@"selected view%ld",(long)the_tag);
    
    
    switch (the_tag) {
        case 1:
        {
        
            MydietViewController *controller1 = [self.storyboard
                                                 instantiateViewControllerWithIdentifier:@"MydietViewController"];
            
            [self.navigationController pushViewController:controller1 animated:YES];
        
        }
            break;
            
        case 2:
        {
            
            MykidnycareViewController *controller2 = [self.storyboard
                                                 instantiateViewControllerWithIdentifier:@"MykidnycareViewController"];
            
            [self.navigationController pushViewController:controller2 animated:YES];
            
        }
            break;
            
        case 3:
        {
            
            SearchForClinicViewController *controller3 = [self.storyboard
                                                 instantiateViewControllerWithIdentifier:@"SearchForClinicViewController"];
            
            [self.navigationController pushViewController:controller3 animated:YES];
            
        }
            break;
            
        case 4:
        {
            
            AboutCKDViewController *controller4 = [self.storyboard
                                                          instantiateViewControllerWithIdentifier:@"AboutCKDViewController"];
            
            [self.navigationController pushViewController:controller4 animated:YES];
            
        }
            break;

        case 5:
        {
            
            MyGroupViewController *controller5 = [self.storyboard
                                                   instantiateViewControllerWithIdentifier:@"MyGroupViewController"];
                
            
            [self.navigationController pushViewController:controller5 animated:YES];
            
        }
            break;

            
        default:
            break;
    }
    
    
    
   


    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
