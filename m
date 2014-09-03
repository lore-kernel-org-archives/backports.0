Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bl2on0110.outbound.protection.outlook.com ([65.55.169.110]:52288
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755690AbaICKil (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Sep 2014 06:38:41 -0400
Message-ID: <5406E7A9.5010609@convergeddevices.net> (sfid-20140903_123843_953876_02E9BB78)
Date: Wed, 3 Sep 2014 11:04:25 +0100
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>
Subject: Re: Compiling error
References: <5405F05E.2090909@convergeddevices.net> <5405F832.8080406@convergeddevices.net> <54063B49.2030700@hauke-m.de>
In-Reply-To: <54063B49.2030700@hauke-m.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thank you Hauke. I do have CONFIG_MODULES in my .config

CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y


I am trying to get TI wireless driver working. According to their 
software release note, the latest supported version is 3.12.


On 02/09/14 22:48, Hauke Mehrtens wrote:
> On 09/02/2014 07:02 PM, tony wrote:
>> Hi,
>>      I am trying to build "backports-3.12.8-1" for my kernel 3.1.10. I am
>> following the instructions in the backports wiki to cross compile for
>> arm. But the compilation fails complaining "‘THIS_MODULE’ undeclared".
>> As suggested by one of the earlier posts in the forum, I tried including
>> #include <linux/module.h>
>> before
>> #include <linux/skbuff.h>
>>   But it did not make any difference.Attached is a error log.
>>
>> Thank you in advance for any help.
>
> This looks strange. You have to compile your kernel with CONFIG_MODULES
> activated, backports needs that.
>
> compat/main.c includes linux/module.h and that file contains
> EXPORT_SYMBOL_GPL(), but that is not found in your build.
>
> Why are you using version 3.12, the current stable version is 3.16?
>
> Hauke
>
