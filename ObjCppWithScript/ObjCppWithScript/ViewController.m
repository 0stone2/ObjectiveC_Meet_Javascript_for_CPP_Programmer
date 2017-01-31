//
//  ViewController.m
//  ObjCppWithScript
//
//  Created by 박 창진 on 2017. 1. 14..
//  Copyright © 2017년 박 창진. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSString *Script = @"Javascript";

    [_Box_1 setTitle: [NSString stringWithFormat:@"1장 - Objective C에서 %@ 호출하기", Script]];
    [_Button_1 setTitle: [NSString stringWithFormat:@"예제 1 - %@ 스크립트\n 파일 실행하기", Script]];
    [_Button_2 setTitle: [NSString stringWithFormat:@"예제 2 - %@ 전역변수\n 조작하기", Script]];
    [_Button_3 setTitle: [NSString stringWithFormat:@"예제 3 - %@ 함수\n 호출하기", Script]];
    
    [_Box_2 setTitle: [NSString stringWithFormat:@"2장 - %@에서 Objective C 호출하기", Script]];
    [_Button_4 setTitle: [NSString stringWithFormat:@"예제 4 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
    [_Button_5 setTitle: [NSString stringWithFormat:@"예제 5 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
    [_Button_6 setTitle: [NSString stringWithFormat:@"예제 6 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)Button_Exit_Click:(id)sender {
    [NSApp terminate:self];
}

- (IBAction)Button_1_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample01.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                                        encoding:NSUTF8StringEncoding
                                                        error:NULL];
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {

    }
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_2_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    JSValue *pValue = NULL;
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample02.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
    
        pValue = [Context evaluateScript:(NSString *)JSCode];
    
        NSLog(@"szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        NSLog(@"nVersion = %d", [Context[@"nVersion"] toInt32]);
    
        Context[@"nVersion"] = @22;
        NSLog(@"New nVersion = %d", [Context[@"nVersion"] toInt32]);

    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
    
    }
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_3_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    JSValue *pValue = NULL;
    
    JSValue * pFunction1;
    JSValue * pFunction2;
    JSValue * pFunction3;
    JSValue * pFunction4;
    JSValue * pFunction5;
    JSValue * pReturnValue;
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample03.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
        
    
        pValue = [Context evaluateScript:(NSString *)JSCode];
    
        NSLog(@"szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        NSLog(@"nVersion = %d", [Context[@"nVersion"] toInt32]);
    
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_1
        //
        
        NSLog(@"[myfunc_1]========================================");
        pFunction1 = Context[@"myfunc_1"];
        [pFunction1 callWithArguments:nil];
    
        NSLog(@"[myfunc_1]szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"[myfunc_1]szWhoamI = %@", [Context[@"szWhoamI"] toString]);
    
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_2
        //
        
        NSLog(@"[myfunc_2]========================================");
        pFunction2 = Context[@"myfunc_2"];
        pReturnValue = [pFunction2 callWithArguments:nil];
    
        NSLog(@"[myfunc_2]Return = %@", [pReturnValue toString]);
        NSLog(@"[myfunc_2]szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"[myfunc_2]szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_3
        //
        
        NSLog(@"[myfunc_3]========================================");
        pFunction3 = Context[@"myfunc_3"];
        pReturnValue = [pFunction3 callWithArguments:nil];
    
        NSLog(@"[myfunc_3]Return 1 = %@", [[pReturnValue toArray] objectAtIndex: 0]);
        NSLog(@"[myfunc_3]Return 2 = %@", [[[pReturnValue toArray] objectAtIndex: 1] intValue]? @"true" : @"false");
        NSLog(@"[myfunc_3]szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"[myfunc_3]szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        NSLog(@"[myfunc_3]nVersion = %d", [Context[@"nVersion"] toInt32]);
        
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_4
        //
        
        NSLog(@"[myfunc_4]========================================");
        pFunction3 = Context[@"myfunc_4"];
        NSString *pArg = @"myfunc_3";
        pArg = @"myfunc_4";
        pReturnValue = [pFunction3 callWithArguments:@[pArg]];
        
        NSLog(@"[myfunc_4]Return 1 = %@", [[pReturnValue toArray] objectAtIndex: 0]);
        NSLog(@"[myfunc_4]Return 2 = %@", [[[pReturnValue toArray] objectAtIndex: 1] intValue]? @"true" : @"false");
        NSLog(@"[myfunc_4]szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"[myfunc_4]szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        NSLog(@"[myfunc_4]nVersion = %d", [Context[@"nVersion"] toInt32]);
        
        
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_5
        //
        
        NSLog(@"[myfunc_5]========================================");
        pFunction5 = Context[@"myfunc_5"];
        pArg = @"myfunc_5";
        NSArray * args = @[pArg, @false];
        pReturnValue = [pFunction5 callWithArguments:args];
    
        NSLog(@"[myfunc_5]Return 1 = %@", [[pReturnValue toArray] objectAtIndex: 0]);
        NSLog(@"[myfunc_5]Return 2 = %@", [[[pReturnValue toArray] objectAtIndex: 1] intValue]? @"true" : @"false");
        NSLog(@"[myfunc_5]szWelcomMessage = %@", [Context[@"szWelcomMessage"] toString]);
        NSLog(@"[myfunc_5]szWhoamI = %@", [Context[@"szWhoamI"] toString]);
        NSLog(@"[myfunc_5]nVersion = %d", [Context[@"nVersion"] toInt32]);
        
    
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        
    }
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

- (IBAction)Button_4_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample05.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        
        Context[@"DbgString"] = ^()
        {
            NSLog(@"DbgString 호출됨");
        };
        
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
        
        [Context evaluateScript:(NSString *)JSCode];
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
    
    }

    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_5_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample05.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        
        Context[@"DbgString"] = ^(NSString *szDbgString)
        {
            NSLog(szDbgString);
        };
        
        Context[@"Sum"] = ^(int  nStart, int nEnd)
        {
            
            int nSum = 0;
            
            if (nStart <= nEnd)
            {
                for (int nIndex = nStart; nIndex <= nEnd; nIndex++) nSum += nIndex;
            }
            else
            {
                for (int nIndex = nEnd; nIndex <= nStart; nIndex++) nSum += nIndex;
            }
            
            return nSum;
        };
        
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
        
        [Context evaluateScript:(NSString *)JSCode];
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_6_Click:(id)sender {
    NSString *ScriptFile = NULL;
    JSContext *Context = NULL;
    NSString *JSCode = NULL;
    
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample06.js"];
        Context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        
        Context[@"DbgString"] = ^(NSString *szDbgString)
        {
            NSLog(szDbgString);
        };
        
        Context[@"SumAndAverage"] = ^(int  nStart, int nEnd)
        {
            
            int nSum = 0;
            int nAverage = 0;
            NSArray *pReturnValue;
            
            if (nStart <= nEnd)
            {
                for (int nIndex = nStart; nIndex <= nEnd; nIndex++) nSum += nIndex;
                nAverage = nSum / (nEnd - nStart + 1);
            }
            else
            {
                for (int nIndex = nEnd; nIndex <= nStart; nIndex++) nSum += nIndex;
                nAverage = nSum / (nStart - nEnd + 1);
            }
            
            
            pReturnValue = [NSArray arrayWithObjects: [NSNumber numberWithInt:nSum], [NSNumber numberWithInt:nAverage]];
        
            return pReturnValue;
        };
        
        JSCode = [NSString stringWithContentsOfFile:ScriptFile
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
        
        [Context evaluateScript:(NSString *)JSCode];
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_7_Click:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_8_Click:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
}


@end
