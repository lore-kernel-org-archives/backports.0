Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:57454 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaECOF2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 3 May 2014 10:05:28 -0400
Received: by mail-lb0-f176.google.com with SMTP id w7so3990843lbi.7
        for <backports@vger.kernel.org>; Sat, 03 May 2014 07:05:26 -0700 (PDT)
Received: from [192.168.1.75] (c-107ae455.213-3-64736c14.cust.bredbandsbolaget.se. [85.228.122.16])
        by mx.google.com with ESMTPSA id qf1sm2598850lbc.8.2014.05.03.07.05.24
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 03 May 2014 07:05:25 -0700 (PDT)
Message-ID: <1399125923.28281.3.camel@lillan> (sfid-20140503_160530_618637_ADBB7579)
Subject: [PATCH] backports: backport-3.15: Include fix
From: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sat, 03 May 2014 16:05:23 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Include string.h to avoid compile issues if warnings are treated as errors:

backports-3.14-1/compat/backport-3.15.c: In function 'backport_devm_kstrdup':
backports-3.14-1/compat/backport-3.15.c:33:2: error: implicit declaration of function 'strlen' [-Werror=implicit-function-declaration]
   size = strlen(s) + 1;
   ^
backports-3.14-1/compat/backport-3.15.c:33:9: warning: incompatible implicit declaration of built-in function 'strlen' [enabled by default]
   size = strlen(s) + 1;
          ^
backports-3.14-1/compat/backport-3.15.c:36:3: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
    memcpy(buf, s, size);
    ^
backports-3.14-1/compat/backport-3.15.c:36:3: warning: incompatible implicit declaration of built-in function 'memcpy' [enabled by default]

Signed-off-by: Richard Röjfors <richard@puffinpack.se>
---
--- a/compat/backport-3.15.c	2014-05-03 15:43:46.229481458 +0200
+++ b/compat/backport-3.15.c	2014-05-03 15:43:59.541481079 +0200
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <string.h>
 
 /**
  * devm_kstrdup - Allocate resource managed space and

