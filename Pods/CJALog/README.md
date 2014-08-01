#CJALog

A simple wrapper around the [`<asl.h>`](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man3/asl.3.html) log functions 

[![Build Status](https://travis-ci.org/carlj/CJALog.png?branch=master)](https://travis-ci.org/carlj/CJALog)
[![Coverage Status](https://coveralls.io/repos/carlj/CJALog/badge.png?branch=master)](https://coveralls.io/r/carlj/CJALog?branch=master)


##Description
You can log a message with different log levels, these levels are defined in [`<asl.h>`:](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man3/asl.3.html)
 
```
#define ASL_LEVEL_EMERG   0
#define ASL_LEVEL_ALERT   1
#define ASL_LEVEL_CRIT    2
#define ASL_LEVEL_ERR     3
#define ASL_LEVEL_WARNING 4
#define ASL_LEVEL_NOTICE  5
#define ASL_LEVEL_INFO    6
#define ASL_LEVEL_DEBUG   7
```

[Check out the description for the different log levels:]( http://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/LoggingErrorsAndWarnings.html#//apple_ref/doc/uid/10000172i-SW8-SW1)
  
Name|Level|Description
--- | --- | ---
Emergency | 0 | The highest priority, usually reserved for catastrophic failures and reboot notices.  
Alert | 1 | A serious failure in a key system.  
Critical | 2 | A failure in a key system.  
Error | 3 | Something has failed.  
Warning | 4 | Something is amiss and might fail if not corrected.  
Notice | 5 | Things of moderate interest to the user or administrator.  
Info | 6 | The lowest priority that you would normally log, and purely informational in nature.  
Debug | 7 | The lowest priority, and normally not logged except for messages from the kernel.  
 
By default on iOS the only items that are printed to the console are items up to level `ASL_LEVEL_NOTICE`.
 
And check out the best practive section in the above link:
 
Treat your log messages as a potentially customer-facing portion of your application, not as purely an internal debugging tool. 
Follow good logging practices to make your logs as useful as possible:
 
* Provide the right amount of information; no more, no less. Avoid creating clutter.
* Avoid logging messages that the user can’t do anything about.
* Use hashtags and log levels to make your log messages easier to search and filter.
 

##Installation
* Drag & Drop `CJALog.h` and `CJALog.m` to your project

##Examples
First of all: take a look at the example project

```objc
CJALogEmergency(@"%s Emergency Log", __FUNCTION__);
  
CJALogAlert(@"%s Alert Log", __FUNCTION__);

CJALogCritical(@"%s Critical Log", __FUNCTION__);

CJALogError(@"%s Error Log", __FUNCTION__);
  
CJALogWarning(@"%s Warning Log", __FUNCTION__);
  
CJALogNotice(@"%s Notice Log", __FUNCTION__);
  
CJALogInfo(@"%s Info Log", __FUNCTION__);
  
CJALogDebug(@"%s Debug Log", __FUNCTION__);
```

You can set your own log leven:
```
CJALogSetSharedLogLevel(ASL_LEVEL_EMERG);
```

By default the ```ASL_LEVEL_DEBUG``` level is set. In the release mode the min. log level is ```ASL_LEVEL_NOTICE```. 

##License
Released under the [MIT license](LICENSE).