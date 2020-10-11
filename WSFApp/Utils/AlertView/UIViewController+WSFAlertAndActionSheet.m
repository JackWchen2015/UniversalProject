//
//  UIViewController+WSFAlertAndActionSheet.m
//  WSFApp
//
//  Created by jack on 2020/9/17.
//  Copyright © 2020 USER. All rights reserved.
//

#import "UIViewController+WSFAlertAndActionSheet.h"
static NSMutableArray *fields = nil;
@implementation UIViewController (WSFAlertAndActionSheet)
#pragma mark - *****  alert view
- (void)AlertWithTitle:(NSString *)title
               message:(NSString *)message
             andOthers:(NSArray<NSString *> *)others
              animated:(BOOL)animated
                action:(click)click
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0)
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                if (action && click)
                {
                    click(idx);
                }
            }]];
        }
        else
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (action && click)
                {
                    click(idx);
                }
            }]];
        }
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - *****  sheet
- (void)ActionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
                 destructive:(NSString *)destructive
           destructiveAction:(click )destructiveAction
                   andOthers:(NSArray <NSString *> *)others
                    animated:(BOOL )animated
                      action:(click )click
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (destructive)
    {
        [alertController addAction:[UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (action)
            {
                destructiveAction(NO_USE);
            }
        }]];
    }
    
    
    [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0)
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (action && click)
                {
                    click(idx);
                }
            }]];
        }
        else
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (action && click)
                {
                    click(idx);
                }
            }]];
        }
        
    }];
    
    [self presentViewController:alertController animated:animated completion:nil];
}


#pragma mark - *****  textField
- (void)AlertWithTitle:(NSString *)title
               message:(NSString *)message
               buttons:(NSArray<NSString *> *)buttons
       textFieldNumber:(NSInteger )number
         configuration:(configuration )configuration
              animated:(BOOL )animated
                action:(clickHaveField )click
{
    if (fields == nil)
    {
        fields = [NSMutableArray array];
    }
    else
    {
        [fields removeAllObjects];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // textfield
    for (NSInteger i = 0; i < number; i++)
    {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            [fields addObject:textField];
            configuration(textField,i);
        }];
    }
    
    // button
    [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0)
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (action && click)
                {
                    click(fields,idx);
                }
            }]];
        }
        else
        {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (action && click)
                {
                    click(fields,idx);
                }
            }]];
        }
    }];
    [self presentViewController:alertController animated:animated completion:nil];
}
@end
