Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34625 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933994AbaJ2Qgu (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 Oct 2014 12:36:50 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so5101958wib.13
        for <backports@vger.kernel.org>; Wed, 29 Oct 2014 09:36:48 -0700 (PDT)
Received: from [192.168.1.171] ([109.160.179.192])
        by mx.google.com with ESMTPSA id fu5sm5720861wjb.26.2014.10.29.09.36.46
        for <backports@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:36:47 -0700 (PDT)
Message-ID: <5451179D.6020009@trego.co.il> (sfid-20141029_173700_652943_FC9D8B2D)
Date: Wed, 29 Oct 2014 18:36:45 +0200
From: Eyal Ben-Sasson <eyal@trego.co.il>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: build backports-20140905 against 2.6.39 kernel failure
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am trying to build backports-20140905 against 2.6.39 kernel and the 
build fails on compat-3.0.c with the following:

backport-include/linux/compat.h:18:69: error: expected ‘;’, ‘,’ or ‘)’ 
before ‘*’ token

If I comment out the line in compat.h I get error on compat-3.5.c

ptp_clock_kernel.h:5:41: fatal error: linux/ptp_clock_kernel.h: No such 
file or directory

I saw a previous Thread " 3.14-1 Compile Problem for 2.6.39.4 Kernel" 
which looks similar, but in my case I have CRYPTO_CCM=m.
Any new suggestions?
I understand the backports is tested against 2.6.39 successfully. Where 
can I see the 2.6.39 .config file?
