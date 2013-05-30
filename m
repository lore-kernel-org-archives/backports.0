Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:50030 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab3E3SRU (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 May 2013 14:17:20 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so452954veb.27
        for <backports@vger.kernel.org>; Thu, 30 May 2013 11:17:19 -0700 (PDT)
Received: from larrylap.lan (cpe-75-81-36-228.kc.res.rr.com. [75.81.36.228])
        by mx.google.com with ESMTPSA id s6sm27820162vdj.5.2013.05.30.11.17.16
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 11:17:19 -0700 (PDT)
Message-ID: <51A797A6.5070804@lwfinger.net> (sfid-20130530_201722_981325_81CBAC11)
Date: Thu, 30 May 2013 13:17:10 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: Question about configuration for alx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am trying to help an openSUSE user that needs driver alx for his wired device. 
I see that backports has the code, but it cannot be configured due to the 
following statements in drivers/net/wireless/atheros/Kconfig:

config ALX
         depends on !BACKPORT_KERNEL_2_6_28
         depends on n
         tristate "Qualcomm Atheros L1F Gigabit Ethernet support"
         depends on m

The "depends on n" is the culprit. Is this deliberate because the driver code is 
not ready, or is this a bug?

Thanks,

Larry
