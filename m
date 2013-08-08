Return-path: <backports-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:49984 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934143Ab3HHLzN (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 Aug 2013 07:55:13 -0400
Message-ID: <520384E4.1010205@lenbrook.com> (sfid-20130808_135516_458338_4C18209F)
Date: Thu, 08 Aug 2013 07:45:40 -0400
From: Jonathan Bagg <jbagg@lenbrook.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: Issue reading kernel config
References: <1375338204-2021-8-git-send-email-sujith@msujith.org>  <1375370826-1387-1-git-send-email-sujith@msujith.org>  <51FA8ECD.7070401@lenbrook.com> <20130801174749.GC10904@shaftnet.org>  <51FAB31F.6050207@lenbrook.com> <5202A643.8080404@lenbrook.com>  <5202AF0E.9010201@lenbrook.com> (sfid-20130807_223322_404420_CA68A7F6) <1375943844.8186.0.camel@jlt4.sipsolutions.net>
In-Reply-To: <1375943844.8186.0.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13-08-08 02:37 AM, Johannes Berg wrote:
> On Wed, 2013-08-07 at 16:33 -0400, Jonathan Bagg wrote:
>> So I had a look at the Kconfig file and realised it isn't a kernel
>> config.  If I add
>>
>> config BT
>>       def_bool y
>>
>> under the "# some hacks ..." section, I can enable BT drivers in
>> backports in the menuconfig.  So if a kconfig depends on an external
>> config, there is no way to feed in a kernel config to backports?  you
>> list external config under "# some hacks ..." section?
> The script should create a dummy Kconfig.kernel from your
> kernel's .config, and read that for the dependencies from the kernel.
I'd like to figure out why it isn't working.  Which script reads the 
kernel's .config?

Jon
