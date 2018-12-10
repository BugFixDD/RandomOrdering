//
//  ViewController.m
//  点餐系统
//
//  Created by 树清吴 on 2017/10/28.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Category.h"
#import "UILabel+category.h"
#import "UIBarButtonItem+category.h"
#import "UIView+SetFrame.h"

#define kSearchBar  @"searchBar"
#define kPickerVw  @"pickerVw"
#define kAutoSelectLbl  @"autoSelectLbl"
#define kShowLbl  @"showLbl"
#define kFruitLbl  @"fruitLbl"
#define kFoodLbl  @"foodLbl"
#define kDrinkLbl  @"drinkLbl"
#define kSelectedFruitLbl  @"selectedFruitLbl"
#define kSelectedFruitLbl  @"selectedFruitLbl"
#define kSelectedFruitLbl  @"selectedFruitLbl"
//#define kSelectedFruitLbl  @"selectedFruitLbl"


@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *foodArray;
@property (nonatomic, strong) UIPickerView *pickerVw;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIBarButtonItem *randomItem;
@property (nonatomic, strong) UIButton *doneBtn;
@property (nonatomic, strong) UIButton *randomBtn;
@property (nonatomic, strong) UILabel *autoSelectLbl;
@property (nonatomic, strong) UILabel *showLbl;

@property (nonatomic, strong) UILabel *fruitLbl;
@property (nonatomic, strong) UILabel *foodLbl;
@property (nonatomic, strong) UILabel *drinkLbl;
@property (nonatomic, strong) UILabel *selectedFruitLbl;
@property (nonatomic, strong) UILabel *selectedFoodLbl;
@property (nonatomic, strong) UILabel *selectedDrinkLbl;

@property (nonatomic, strong) NSOperationQueue *queue;

/**
 是否在随机选择
 */
@property (nonatomic, assign) BOOL isRun;

@end

@implementation ViewController

#pragma mark -- 按钮的点击事件

/**
 确定按钮

 @param sender 按钮
 */
- (void)doneBtnClick:(UIButton *)sender{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"点餐成功" message:@"请稍侯......" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

/**
 点击随机按钮

 @param sender 按钮
 */
- (void)randomBtnClick:(UIButton *)sender{
    if (self.isRun == NO) {
        // 随机功能
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        
        self.isRun = YES;
        [self.queue addOperationWithBlock:^{
            while (self.isRun) {
                [NSThread sleepForTimeInterval:0.15];
                NSInteger num1 = arc4random_uniform((uint32_t)[self.foodArray[0] count]);
                NSInteger num2 = arc4random_uniform((uint32_t)[self.foodArray[1] count]);
                NSInteger num3 = arc4random_uniform((uint32_t)[self.foodArray[2] count]);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    self.selectedFruitLbl.text = [self.foodArray[0] objectAtIndex:num1];
                    self.selectedFoodLbl.text = [self.foodArray[1] objectAtIndex:num2];
                    self.selectedDrinkLbl.text = [self.foodArray[2] objectAtIndex:num3];
//                    [self.pickerVw selectRow:num1 inComponent:0 animated:YES];
//                    [self.pickerVw selectRow:num2 inComponent:1 animated:YES];
//                    [self.pickerVw selectRow:num3 inComponent:2 animated:YES];

                }];
            }
        }];

    }else{
        // 暂停功能
        [sender setTitle:@"随机" forState:UIControlStateNormal];
        self.isRun = NO;
        
        NSInteger num1 = [self.foodArray[0] indexOfObject:self.selectedFruitLbl.text];
        NSInteger num2 = [self.foodArray[1] indexOfObject:self.selectedFoodLbl.text];
        NSInteger num3 = [self.foodArray[2] indexOfObject:self.selectedDrinkLbl.text];
        
        [self.pickerVw selectRow:num1 inComponent:0 animated:YES];
        [self.pickerVw selectRow:num2 inComponent:1 animated:YES];
        [self.pickerVw selectRow:num3 inComponent:2 animated:YES];
    }
}



#pragma mark -- pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.foodArray.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *array = self.foodArray[component];
    return array.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *array = self.foodArray[component];
    return array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *array = self.foodArray[component];
    NSString *text = array[row];
    if (component == 0) {
        self.selectedFruitLbl.text = text;
    }else if (component == 1){
        self.selectedFoodLbl.text = text;
    }else if (component == 2){
        self.selectedDrinkLbl.text = text;
    }
}

// MARK: searchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    for (int i = 0; i < self.foodArray.count; i ++) {
        NSArray *array = self.foodArray[i];
        for (int y = 0; y < array.count; y ++) {
            NSString *foodName = array[y];
            if ([foodName containsString:searchText]) {
                [self.pickerVw selectRow:y inComponent:i animated:YES];
                [self pickerView:self.pickerVw didSelectRow:y inComponent:i];
            }
        }
    }


}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

// MARK: 页面加载完成
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加控件
    [self addSubViews];
    
    //屏幕适配, 设置外观
    [self setupAppearance];
    
    
}

/**
 屏幕适配, 设置外观
 */
- (void)setupAppearance{
    self.navigationItem.title = @"点餐系统";
    
    self.navigationItem.leftBarButtonItem = self.randomItem;
    
    // 设置searchBar的自动布局
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(0)-[%@]-(0)-|", kSearchBar] options:0 metrics:@{
                                                                                                                                                                
                                                                                                                                                                }views:@{
                                                                                                                                                                         kSearchBar: self.searchBar
                                                                                                                                                                         }]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:44]];
    //    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(topMargin)-[%@]", kSearchBar] options:0 metrics:@{
                                                                                                                                                                  @"topMargin": @(64)
                                                                                                                                                                  }views:@{
                                                                                                                                                                           kSearchBar: self.searchBar
                                                                                                                                                                           }]];
    
    // 设置autoSelectLbl的约束
    self.autoSelectLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(15)-[%@]-(0)-|", kAutoSelectLbl] options:0 metrics:@{
                                                                                                                                                                     
                                                                                                                                                                     }views:@{
                                                                                                                                                                              kAutoSelectLbl: self.autoSelectLbl
                                                                                                                                                                              }]];
    [self.autoSelectLbl addConstraint:[NSLayoutConstraint constraintWithItem:self.autoSelectLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:30]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@]-(searchBarH)-[%@]", kSearchBar, kAutoSelectLbl] options:0 metrics:@{
                                                                                                                                                                                      
                                                                                                                                                                                      @"searchBarH": @(self.searchBar.height)
                                                                                                                                                                                      }views:@{
                                                                                                                                                                                               kAutoSelectLbl: self.autoSelectLbl,
                                                                                                                                                                                               kSearchBar: self.searchBar
                                                                                                                                                                                               }]];
    
    // 设置pickerView的约束
    self.pickerVw.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(0)-[%@]-(0)-|", kPickerVw] options:0 metrics:nil views:@{
                                                                                                                                                                         kPickerVw: self.pickerVw
                                                                                                                                                                         }]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerVw attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.35 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@]-(autoSelectLblH)-[%@]", kAutoSelectLbl, kPickerVw]options:0 metrics:@{
                                                                                                                                                                                        
                                                                                                                                                                                        @"autoSelectLblH": @(self.autoSelectLbl.height)
                                                                                                                                                                                        }views:@{
                                                                                                                                                                                                 kPickerVw: self.pickerVw,
                                                                                                                                                                                                 kAutoSelectLbl: self.autoSelectLbl
                                                                                                                                                                                                 }]];
    
    // 设置showLbl的约束
    self.showLbl.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[%@]-(0)-[%@]", kAutoSelectLbl, kShowLbl] options:0 metrics:@{
    //                                                                                                                                                                                                                 @"autoSelectLblH": @(self.autoSelectLbl.width)
    //                                                                                                                                                                                                                 }views:@{
    //                                                                                                                                                                                                                          kAutoSelectLbl: self.autoSelectLbl,
    //                                                                                                                                                                                                                          kShowLbl: self.showLbl
    //                                                                                                                                                                                                                          }]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.showLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.autoSelectLbl attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    //    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.showLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.autoSelectLbl attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.showLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.autoSelectLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.showLbl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.autoSelectLbl attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerVw attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.showLbl attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    // 设置fruitLbl的约束
    self.fruitLbl.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[%@]-(10)-[%@]", kShowLbl, kFruitLbl] options:0 metrics:@{
    //
    //                                                                                                                                  }views:@{
    //                                                                                                                                           kShowLbl: self.autoSelectLbl,
    //                                                                                                                                           kFruitLbl: self.fruitLbl
    //                                                                                                                                           }]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@]-(10)-[%@]", kShowLbl, kFruitLbl] options:0 metrics:@{
                                                                                                                                                                       
                                                                                                                                                                       }views:@{
                                                                                                                                                                                kShowLbl: self.showLbl,
                                                                                                                                                                                kFruitLbl: self.fruitLbl
                                                                                                                                                                                }]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fruitLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.showLbl attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
    [self.fruitLbl sizeToFit];
    [self.fruitLbl addConstraint:[NSLayoutConstraint constraintWithItem:self.fruitLbl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.fruitLbl.width]];
    [self.fruitLbl addConstraint:[NSLayoutConstraint constraintWithItem:self.fruitLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.fruitLbl.height]];
    
    // 设置foodLbl的约束
    self.foodLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodLbl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    // 设置drinkLbl的约束
    self.drinkLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drinkLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drinkLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.foodLbl attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drinkLbl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drinkLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    CGFloat horizontalMargin = 50;
    
    // 设置selectedFruitLbl的约束
    self.selectedFruitLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFruitLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[fruitLbl]-(horizontalMargin)-[selectedFruitLbl]-(0)-|" options:0 metrics:@{
    //                                                      @"horizontalMargin":@(horizontalMargin)
    //                                                                                                      }views:@{
    //                                                      @"fruitLbl": self.fruitLbl,
    //                                                      @"selectedFruitLbl": self.selectedFruitLbl
    //                                                                                                          }]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFruitLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFruitLbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeTrailing multiplier:1 constant:horizontalMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFruitLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    // 设置selectedFoodLbl的约束
    self.selectedFoodLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFoodLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.foodLbl attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFoodLbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.selectedFruitLbl attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFoodLbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.selectedFruitLbl attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedFoodLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    // 设置selectedDrinkLbl的约束
    self.selectedDrinkLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedDrinkLbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.drinkLbl attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedDrinkLbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.selectedFruitLbl attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedDrinkLbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.selectedFruitLbl attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedDrinkLbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fruitLbl attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    // 设置doneBtn的约束
    [self.doneBtn sizeToFit];
    self.doneBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.doneBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.doneBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:50]];
    [self.doneBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.doneBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.doneBtn.width]];
    [self.doneBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.doneBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.doneBtn.height]];
    
    // 设置randomBtn的约束
    self.randomBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.randomBtn sizeToFit];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.randomBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.doneBtn attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.randomBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50]];
    
}

/**
 添加控件
 */
- (void)addSubViews{
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.autoSelectLbl];
    [self.view addSubview:self.pickerVw];
    [self.view addSubview:self.showLbl];
    [self.view addSubview:self.fruitLbl];
    [self.view addSubview:self.foodLbl];
    [self.view addSubview:self.drinkLbl];
    [self.view addSubview:self.selectedFruitLbl];
    [self.view addSubview:self.selectedFoodLbl];
    [self.view addSubview:self.selectedDrinkLbl];
    [self.view addSubview:self.doneBtn];
    [self.view addSubview:self.randomBtn];
}


#pragma mark -- 懒加载
- (NSArray *)foodArray{
    if (_foodArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"01foods.plist" ofType:nil];
        _foodArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _foodArray;
}

- (UIPickerView *)pickerVw{
    if (_pickerVw == nil) {
        _pickerVw = [UIPickerView new];
        _pickerVw.delegate = self;
        _pickerVw.dataSource = self;
//        _pickerVw.backgroundColor = [UIColor lightGrayColor];
    }
    return _pickerVw;
}

- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [UISearchBar new];
        _searchBar.placeholder = @"请输入要搜索的菜名";
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.keyboardType = UIReturnKeyDefault;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = [UIColor orangeColor];
        
        // 设置_searchBar取消按钮为中文
        for (UIView *view in _searchBar.subviews[0].subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
    return _searchBar;
}

- (UIButton *)doneBtn{
    if (_doneBtn == nil) {
        _doneBtn = [UIButton normalButtonWithTitle:@"确定" target:self action:@selector(doneBtnClick:)];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _doneBtn;
}

- (UIButton *)randomBtn{
    if (_randomBtn == nil) {
        _randomBtn = [UIButton normalButtonWithTitle:@"随机" target:self action:@selector(randomBtnClick:)];
        [_randomBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _randomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _randomBtn;
}

- (UILabel *)autoSelectLbl{
    if (_autoSelectLbl == nil) {
        _autoSelectLbl = [UILabel labelWithTitle:@"请自动选择:" size:14 textAlignment:NSTextAlignmentLeft color:[UIColor lightGrayColor]];
    }
    return _autoSelectLbl;
}

- (UILabel *)showLbl{
    if (_showLbl == nil) {
        _showLbl = [UILabel labelWithTitle:@"所选套餐如下:" size:14 textAlignment:NSTextAlignmentLeft color:[UIColor lightGrayColor]];
    }
    return _showLbl;
}

- (UILabel *)fruitLbl{
    if (_fruitLbl == nil) {
        _fruitLbl = [UILabel labelWithTitle:@"水果:" size:18 textAlignment:NSTextAlignmentCenter color:[UIColor lightGrayColor]];
    }
    return _fruitLbl;
}

- (UILabel *)foodLbl{
    if (_foodLbl == nil) {
        _foodLbl = [UILabel labelWithTitle:@"主菜:" size:18 textAlignment:NSTextAlignmentCenter color:[UIColor lightGrayColor]];
    }
    return _foodLbl;
}

- (UILabel *)drinkLbl{
    if (_drinkLbl == nil) {
        _drinkLbl = [UILabel labelWithTitle:@"饮料:" size:18 textAlignment:NSTextAlignmentCenter color:[UIColor lightGrayColor]];
    }
    return _drinkLbl;
}

- (UILabel *)selectedFruitLbl{
    if (_selectedFruitLbl == nil) {
        _selectedFruitLbl = [UILabel labelWithTitle:[self.foodArray[0] objectAtIndex:0] size:18 textAlignment:NSTextAlignmentLeft color:[UIColor orangeColor]];
        _selectedFruitLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _selectedFruitLbl;
}

- (UILabel *)selectedFoodLbl{
    if (_selectedFoodLbl == nil) {
        _selectedFoodLbl = [UILabel labelWithTitle:[self.foodArray[1] firstObject] size:18 textAlignment:NSTextAlignmentLeft color:[UIColor orangeColor]];
        _selectedFoodLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _selectedFoodLbl;
}

- (UILabel *)selectedDrinkLbl{
    if (_selectedDrinkLbl == nil) {
        _selectedDrinkLbl = [UILabel labelWithTitle:[self.foodArray[2] firstObject] size:18 textAlignment:NSTextAlignmentLeft color:[UIColor orangeColor]];
        _selectedDrinkLbl.textAlignment = NSTextAlignmentLeft;

    }
    return _selectedDrinkLbl;
}

- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

@end





