//
//  CJALog.h
//  CJALog
//
//  Created by Carl Jahn on 06.09.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#include <asl.h>
#import <Foundation/Foundation.h>

/**
 CJALog is a simple wrapper around the ASL log functions.
 
 The log levels are defined in asl.h:
 
 #define ASL_LEVEL_EMERG   0
 #define ASL_LEVEL_ALERT   1
 #define ASL_LEVEL_CRIT    2
 #define ASL_LEVEL_ERR     3
 #define ASL_LEVEL_WARNING 4
 #define ASL_LEVEL_NOTICE  5
 #define ASL_LEVEL_INFO    6
 #define ASL_LEVEL_DEBUG   7
 
 Check out the description for the different log levels:
 
 http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/LoggingErrorsAndWarnings.html#//apple_ref/doc/uid/10000172i-SW8-SW1
 
 Emergency (level 0) - The highest priority, usually reserved for catastrophic failures and reboot notices.
 Alert     (level 1) - A serious failure in a key system.
 Critical  (level 2) - A failure in a key system.
 Error     (level 3) - Something has failed.
 Warning   (level 4) - Something is amiss and might fail if not corrected.
 Notice    (level 5) - Things of moderate interest to the user or administrator.
 Info      (level 6) - The lowest priority that you would normally log, and purely informational in nature.
 Debug     (level 7) - The lowest priority, and normally not logged except for messages from the kernel.
 
 By default on iOS the only items that are printed to the console are items up to level ASL_LEVEL_NOTICE.
 
 And check out the best practive section in the above link:
 
 Treat your log messages as a potentially customer-facing portion of your application, not as purely an internal debugging tool. 
 Follow good logging practices to make your logs as useful as possible:
 
 * Provide the right amount of information; no more, no less. Avoid creating clutter.
 * Avoid logging messages that the user can’t do anything about.
 * Use hashtags and log levels to make your log messages easier to search and filter.
 
 */

#ifndef CJA_LOG_COMPILE_LOG_LEVEL

  #ifdef DEBUG

    #define CJA_LOG_COMPILE_LOG_LEVEL ASL_LEVEL_DEBUG
  #else

    #define CJA_LOG_COMPILE_LOG_LEVEL ASL_LEVEL_NOTICE
  #endif

#endif

/**
 Sets the global log level to print all messages up to the given level
 
 @param level ASL log level (ASL_LEVEL_EMERG upto ASL_LEVEL_DEBUG) 
 */
void CJALogSetSharedLogLevel(NSUInteger level);

/**
 Prints the log to STDERR_FILENO with the given level and format
 
 @param level ASL log level (ASL_LEVEL_EMERG upto ASL_LEVEL_DEBUG)
 @param format the formated string
 */
BOOL CJALogWithLevel(NSUInteger level, NSString *format, ...);


#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_EMERG
#define CJALogEmergency(format, ...) CJALogWithLevel(ASL_LEVEL_EMERG, format, ##__VA_ARGS__)
#else
#define CJALogEmergency(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_ALERT
#define CJALogAlert(format, ...) CJALogWithLevel(ASL_LEVEL_ALERT, format, ##__VA_ARGS__)
#else
#define CJALogAlert(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_CRIT
#define CJALogCritical(format, ...) CJALogWithLevel(ASL_LEVEL_CRIT, format, ##__VA_ARGS__)
#else
#define CJALogCritical(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_ERR
#define CJALogError(format, ...) CJALogWithLevel(ASL_LEVEL_ERR, format, ##__VA_ARGS__)
#else
#define CJALogError(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_WARNING
#define CJALogWarning(format, ...) CJALogWithLevel(ASL_LEVEL_WARNING, format, ##__VA_ARGS__)
#else
#define CJALogWarning(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_NOTICE
#define CJALogNotice(format, ...) CJALogWithLevel(ASL_LEVEL_NOTICE, format, ##__VA_ARGS__)
#else
#define CJALogNotice(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_INFO
#define CJALogInfo(format, ...) CJALogWithLevel(ASL_LEVEL_INFO, format, ##__VA_ARGS__)
#else
#define CJALogInfo(...)
#endif

#if CJA_LOG_COMPILE_LOG_LEVEL >= ASL_LEVEL_DEBUG
#define CJALogDebug(format, ...) CJALogWithLevel(ASL_LEVEL_DEBUG, format, ##__VA_ARGS__)
#else
#define CJALogDebug(...)
#endif



