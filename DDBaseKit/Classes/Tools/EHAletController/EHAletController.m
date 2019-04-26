//
//  EHAletController.m
//  EHome
//
//  Created by Lifee on 2018/8/31.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "EHAletController.h"
#import "ApplicationManager.h"
#import <RTRootNavigationController/RTRootNavigationController.h>

@implementation EHAletController

+ (void)alert:(NSString *)title
          msg:(NSString *)msg
        style:(AlertStyle)style
      actions:(NSArray *)acts
   operations:(void(^)(NSInteger index))op{
    
    UIAlertController * altCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyle)style];
    for (NSInteger i = 0; i < acts.count; i ++) {
        UIAlertAction * act = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",acts[i]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (op) {
                op(i);
            }
        }];
        [altCtl addAction:act];
    }
    if (style == ActionSheet) {
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [altCtl addAction:cancel];
    }
    [AppManager.keyVC presentViewController:altCtl animated:YES completion:nil];

}
+ (void)textfield_alert:(NSString *)title msg:(NSString *)msg textfield_c:(NSInteger)c placeholders:(NSArray *)placeholders actions:(NSArray *)acts operations:(void (^)(NSInteger, NSArray *))op {
    UIAlertController * altCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    NSMutableArray * ts = [NSMutableArray array];
    for (NSInteger i = 0; i <c; i ++) {
        [altCtl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            if (placeholders.count == c) {
                textField.placeholder = placeholders[i];
            }
        }];
    }
    for (NSInteger i = 0; i < acts.count; i ++) {
        UIAlertAction * act = [UIAlertAction actionWithTitle:acts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (NSInteger j = 0; j < altCtl.textFields.count; j ++) {
                UITextField * tf = altCtl.textFields[j];
                [ts addObject:tf.text];
            }
            if (op) {
                op(i , ts);
            }
        }];
        [altCtl addAction:act];
    }
    [AppManager.keyVC presentViewController:altCtl animated:YES completion:nil];
}
@end
