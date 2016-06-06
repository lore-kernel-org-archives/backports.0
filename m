Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34388 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFFJfa (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 Jun 2016 05:35:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id bz2so33989974pad.1
        for <backports@vger.kernel.org>; Mon, 06 Jun 2016 02:35:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
To: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
 <1465138846.2304.0.camel@sipsolutions.net>
 <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com>
 <1465203643.2304.1.camel@sipsolutions.net>
 <5f5554e0-11f5-f072-019d-f5195d2e0116@broadcom.com>
 <1465204361.2304.2.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <9df2d7e4-d8ba-d1f7-d573-fabb8200900f@broadcom.com> (sfid-20160606_113532_201659_A1164050)
Date: Mon, 6 Jun 2016 11:35:20 +0200
MIME-Version: 1.0
In-Reply-To: <1465204361.2304.2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



/On 6-6-2016 11:12, Johannes Berg wrote:
> 
>>> I have a patch for our driver to use it, which is basically only
>>> waiting for this to get into backports :-)
>> So how about incorporating lib/scatterlist.c in backports?
>>
> 
> We need the whole thing? I haven't really had time to look into this,
> sorry.

Here call chain:

dev_coredumpsg() ->
	sg_pcopy_to_buffer() ->
		sg_copy_buffer() ->
			sg_miter_{start,skip,next,stop}() ->
				sg_miter_get_next_page()
				sg_page_iter_page()
				__sg_page_iter_next()
				__sg_page_iter_start()

So not everything is needed. About 350 lines from the 750 lines.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
