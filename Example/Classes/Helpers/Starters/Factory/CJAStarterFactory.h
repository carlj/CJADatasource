//
//  CJAStarterFactory.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

@import Foundation;

@protocol CJAStarter <NSObject>

@required
- (void)start;

@end


@interface CJAStarterFactory : NSObject

- (void)run;
- (void)addStarterClass:(Class<CJAStarter>)class;

@end
