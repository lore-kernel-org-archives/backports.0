Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:61893 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaECOJl (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 3 May 2014 10:09:41 -0400
Received: by mail-la0-f43.google.com with SMTP id c6so3577093lan.2
        for <backports@vger.kernel.org>; Sat, 03 May 2014 07:09:40 -0700 (PDT)
Received: from [192.168.1.75] (c-107ae455.213-3-64736c14.cust.bredbandsbolaget.se. [85.228.122.16])
        by mx.google.com with ESMTPSA id g8sm2169601laf.0.2014.05.03.07.09.38
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 03 May 2014 07:09:39 -0700 (PDT)
Message-ID: <1399126177.28281.6.camel@lillan> (sfid-20140503_160942_797174_9E06271E)
Subject: [PATCH v2] backports: backport-3.15: Include fix
From: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
To: backports@vger.kernel.org
Date: Sat, 03 May 2014 16:09:37 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In this version the correct linux string.h is included.

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
+#include <linux/string.h>
 
 /**
  * devm_kstrdup - Allocate resource managed space and

