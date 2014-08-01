//
//  CJALog.m
//  CJALog
//
//  Created by Carl Jahn on 06.09.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

/*
 #define ASL_LEVEL_EMERG   0
 #define ASL_LEVEL_ALERT   1
 #define ASL_LEVEL_CRIT    2
 #define ASL_LEVEL_ERR     3
 #define ASL_LEVEL_WARNING 4
 #define ASL_LEVEL_NOTICE  5
 #define ASL_LEVEL_INFO    6
 #define ASL_LEVEL_DEBUG   7
 */

#import "CJALog.h"

void CJALogInit() {
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    asl_add_log_file(NULL, STDERR_FILENO);
  });
  
}

void CJALogSetSharedLogLevel(NSUInteger level) {
  
  asl_set_filter(NULL, ASL_FILTER_MASK_UPTO(level) );
}


BOOL CJALogWithLevel(NSUInteger level, NSString *format, ...) {
  
  CJALogInit();
  
  va_list ap;
  va_start(ap,format);
  
  NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
  int result = asl_log(NULL, NULL, (int)level, "%s", [message UTF8String]);

  va_end(ap);

  return !result;
}