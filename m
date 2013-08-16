Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55039 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab3HPSEX (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 14:04:23 -0400
Message-ID: <520E699F.8040601@hauke-m.de> (sfid-20130816_200425_780265_E711C857)
Date: Fri, 16 Aug 2013 20:04:15 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 08/13] backports: revert the sysfs api change
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>  <1376674003-5801-8-git-send-email-hauke@hauke-m.de>  (sfid-20130816_192740_585582_63BCDE6E) <1376674550.15299.27.camel@jlt4.sipsolutions.net>
In-Reply-To: <1376674550.15299.27.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/16/2013 07:35 PM, Johannes Berg wrote:
> On Fri, 2013-08-16 at 19:26 +0200, Hauke Mehrtens wrote:
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>> +#define BUS_ATTR_RW(_name)
>> +#define BUS_ATTR_RO(_name)
>> +#define DRIVER_ATTR_RW(_name)
>> +#define DRIVER_ATTR_RO(_name)
>> +#define CLASS_ATTR_RW(_name)
>> +#define CLASS_ATTR_RO(_name)
>> +#define DEVICE_ATTR_RW(_name)
>> +#define DEVICE_ATTR_RO(_name)
>> +#endif
> 
> Is that part really helpful? Seems you'd want it to fail, or am I
> misunderstanding it?
> 
> johannes
> 
This is done to eliminate these warnings:

/net/wireless/sysfs.c:36:1: warning: type defaults to ‘int’ in
declaration of ‘DEVICE_ATTR_RO’ [-Wimplicit-int]
/net/wireless/sysfs.c:36:1: warning: parameter names (without types) in
function declaration [enabled by default]
/net/wireless/sysfs.c:37:1: warning: type defaults to ‘int’ in
declaration of ‘DEVICE_ATTR_RO’ [-Wimplicit-int]
/net/wireless/sysfs.c:37:1: warning: parameter names (without types) in
function declaration [enabled by default]
/net/wireless/sysfs.c:38:1: warning: type defaults to ‘int’ in
declaration of ‘DEVICE_ATTR_RO’ [-Wimplicit-int]
/net/wireless/sysfs.c:38:1: warning: parameter names (without types) in
function declaration [enabled by default]
/net/wireless/sysfs.c:46:8: warning: type defaults to ‘int’ in
declaration of ‘DEVICE_ATTR_RO’ [-Wimplicit-int]
/net/wireless/sysfs.c:46:1: warning: parameter names (without types) in
function declaration [enabled by default]
/net/wireless/sysfs.c:64:8: warning: type defaults to ‘int’ in
declaration of ‘DEVICE_ATTR_RO’ [-Wimplicit-int]
/net/wireless/sysfs.c:64:1: warning: parameter names (without types) in
function declaration [enabled by default]
/net/wireless/sysfs.c:64:8: warning: ‘DEVICE_ATTR_RO’ declared ‘static’
but never defined [-Wunused-function]

With this change I get an other warning. ;-)

I do not like this whole patch that much, do you have a better idea to
backport this change:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f0bc99c84349ce87af5b35839d19bfb17bb9b27f

Hauke
