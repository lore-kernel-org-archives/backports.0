Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33269 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbcFCIkv (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 3 Jun 2016 04:40:51 -0400
Received: by mail-pa0-f44.google.com with SMTP id ec8so7007195pac.0
        for <backports@vger.kernel.org>; Fri, 03 Jun 2016 01:40:51 -0700 (PDT)
Subject: Re: [PATCH] backports: update devcoredump patch
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net>
 <1464703413.3076.31.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <67751df1-34ee-6e9f-3dd5-7b9a8400f25e@broadcom.com> (sfid-20160603_104054_451767_05E04900)
Date: Fri, 3 Jun 2016 10:40:46 +0200
MIME-Version: 1.0
In-Reply-To: <1464703413.3076.31.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 31-5-2016 16:03, Johannes Berg wrote:
> On Tue, 2016-05-31 at 15:49 +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Changed upstream by commit 522566376a3f ("devcoredump:
>> add scatterlist support").
>>
> This isn't working.

You already have something that is working? Otherwise, I have to dive in
to fix my nightly builds.

Gr. AvS
--
To unsubscribe from this list: send the line "unsubscribe backports" in
