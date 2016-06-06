Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33022 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbcFFJKg (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 Jun 2016 05:10:36 -0400
Received: by mail-pf0-f180.google.com with SMTP id y124so5521987pfy.0
        for <backports@vger.kernel.org>; Mon, 06 Jun 2016 02:10:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
To: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
 <1465138846.2304.0.camel@sipsolutions.net>
 <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com>
 <1465203643.2304.1.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5f5554e0-11f5-f072-019d-f5195d2e0116@broadcom.com> (sfid-20160606_111038_783741_83202F35)
Date: Mon, 6 Jun 2016 11:10:25 +0200
MIME-Version: 1.0
In-Reply-To: <1465203643.2304.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 6-6-2016 11:00, Johannes Berg wrote:
> 
>>> I think, in order to make the new dev_coredumpsg() [or whatever
>>> it's
>>> called] function generally available, we have to also adjust the
>>> kernel
>>> version where the backported one gets used.
>> True. As there are no users right now we could opt to remove the new
>> function using devcoredump.patch. Or can we expect a driver using it
>> soon.
>>
> 
> I have a patch for our driver to use it, which is basically only
> waiting for this to get into backports :-)

So how about incorporating lib/scatterlist.c in backports?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
