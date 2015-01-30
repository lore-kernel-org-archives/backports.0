Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36235 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbbA3K6v (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Jan 2015 05:58:51 -0500
Message-ID: <54CB63E9.3090504@hauke-m.de> (sfid-20150130_115904_402687_8928D095)
Date: Fri, 30 Jan 2015 11:58:49 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 2/3] header: add linux/hdmi.h
References: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>	 <1422055240-4753-3-git-send-email-hauke@hauke-m.de>	 (sfid-20150124_002050_356021_E7A9E878) <1422261618.1890.11.camel@sipsolutions.net>
In-Reply-To: <1422261618.1890.11.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/26/2015 09:40 AM, Johannes Berg wrote:
> On Sat, 2015-01-24 at 00:20 +0100, Hauke Mehrtens wrote:
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  backport/backport-include/linux/hdmi.h | 41 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 backport/backport-include/linux/hdmi.h
>>
>> diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
>> new file mode 100644
>> index 0000000..a6d6880
>> --- /dev/null
>> +++ b/backport/backport-include/linux/hdmi.h
> 
> Would it make sense to automatically copy & slightly patch this file in
> case it gets extended later?

Yes that would be better, this file only contains some enums for things
defined in the hdmi standard and no interfaces to other in kernel
subsystems, it should be safe to just copy the file.

Hauke
