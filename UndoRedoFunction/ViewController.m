//
//  ViewController.m
//  UndoRedoFunction
//
//  Created by 丁飞 on 17/5/11.
//  Copyright © 2017年 XOX. All rights reserved.
//
/**
 *  撤销重做原理：
 *  通过栈进行操作，将操作从栈加入，撤销即移除操作，恢复则加入
 *  具体实现注意：针对某个属性值的变化进行改变记录：传入是最终的需要改变的值，在方法内将属性值改变。
 *  撤销和重做：对整个方法
 *
 *  @return
 */
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *redoBtn;
@property (weak, nonatomic) IBOutlet UIButton *undoBtn;

@end

@implementation ViewController
{
    NSUndoManager *undoManager;
    int  i;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    undoManager = [[NSUndoManager alloc]init];
    i = 0;
}
- (IBAction)addOperation:(id)sender {
    i ++;
     [self changeShowLabel:[NSString stringWithFormat:@"操作%d",i]];
}

- (IBAction)undoAndRedoOperation:(UIButton *)sender {
    if (sender.tag == 100) {
        if (undoManager.canUndo) {
            [undoManager undo];  //撤销
        }
        
    }else{
        if (undoManager.canRedo) {
            [undoManager redo];  //恢复
        }
    }

}

- (void)changeShowLabel:(NSString *)string{
    if (![string isEqualToString:self.showLabel.text]) {
        [[undoManager prepareWithInvocationTarget:self] changeShowLabel:self.showLabel.text];
        self.showLabel.text = string;
        i = [[string substringFromIndex:string.length-1] intValue];
    }
}

@end
