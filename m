Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35073 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbcFFI61 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 Jun 2016 04:58:27 -0400
Received: by mail-pf0-f173.google.com with SMTP id g64so65059485pfb.2
        for <backports@vger.kernel.org>; Mon, 06 Jun 2016 01:58:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
To: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
 <1465138846.2304.0.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com> (sfid-20160606_105839_344648_FE70AC95)
Date: Mon, 6 Jun 2016 10:58:18 +0200
MIME-Version: 1.0
In-Reply-To: <1465138846.2304.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 5-6-2016 17:00, Johannes Berg wrote:
> On Sun, 2016-06-05 at 11:30 +0200, Arend van Spriel wrote:
>> Due to changes in include/linux/devcoredump.h the patch needs to
>> be updated.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> This patch is another shot at devcoredump patch. It just fixes
>> applying the patch. However, the resulting file now uses the
>> scatterlist function sg_pcopy_to_buffer() so that will need a
>> backport for kernels before v3.11.
>>
> I think, in order to make the new dev_coredumpsg() [or whatever it's
> called] function generally available, we have to also adjust the kernel
> version where the backported one gets used.

True. As there are no users right now we could opt to remove the new
function using devcoredump.patch. Or can we expect a driver using it soon.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
