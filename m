Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:48812 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaEBIIn (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 2 May 2014 04:08:43 -0400
Message-ID: <53635288.1090701@broadcom.com> (sfid-20140502_100846_959641_CBA4E52C)
Date: Fri, 2 May 2014 10:08:40 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH V2] backports: lib: remove raising ExecutionError exception
References: <1398422668-11735-1-git-send-email-arend@broadcom.com> <1398765498-6957-1-git-send-email-arend@broadcom.com> <20140502010615.GC957@garbanzo.do-not-panic.com>
In-Reply-To: <20140502010615.GC957@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/02/14 03:06, Luis R. Rodriguez wrote:
> On Tue, Apr 29, 2014 at 11:58:18AM +0200, Arend van Spriel wrote:
>> In spatch a ExecutionError was raised, but that causes the thread
>> to finish without closing the outfile and more importantly without
>> putting (ret, fn) tuple on the return queue. This results in the
>> threaded_spatch routine to get stuck on the ret_q.get() call. This
>> patch removes raising the ExecutionError and just return the tuple.
>> The non-zero return code will result in ExecutionErrorThread exception
>> anyway.
>>
>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>> ---
>> A bit late but here is the rebased version.
>
> Thanks! Perhaps you're on an outdated tree, the latest tree is:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

Definitely barking up the wrong tree ;-)

$ git remote show origin
* remote origin
   Fetch URL: 
git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git

> I rebased your patch to fit on top of that though so no need to send
> another patch, thanks a lot!

Gr. AvS
