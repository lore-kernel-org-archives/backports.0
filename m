Return-Path: <SRS0=LA5M=NC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2BC67863
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80020663
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 20:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IHR6JqYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeJWFGj (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:06:39 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41580 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeJWFGj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 23 Oct 2018 01:06:39 -0400
Received: by mail-yb1-f194.google.com with SMTP id e16-v6so16758363ybk.8
        for <backports@vger.kernel.org>; Mon, 22 Oct 2018 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oMGQ1m1eDKJ9I8aKFtfJKlzYZmlL5z/XqlOF178Dalo=;
        b=IHR6JqYwBR236qWYJEy8zwPGAjBAZou6tYqW3SQEzdzFQMUsmuWxZ7NmhryoPq4qJf
         Vf9FS9maJpo2aaJLbbn/XPuGTDTNx+luMCebfsCpfKR4YJeBPEWoAfrRhDayK8TrQCH9
         NEs7+PJEr9+7cCiK54RojqrEW4IzND8BMUvn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oMGQ1m1eDKJ9I8aKFtfJKlzYZmlL5z/XqlOF178Dalo=;
        b=ZNJdGBJfRvg79Y8S3UMcO5nzkv0J3ZLf7u1Grlt4q5IwUCbaNsSfOjV/XlJmBDltQz
         2mEypna4sOR7G4Km87aLX0C/4PEAvgqnD6Z1KkyAfatcrx6jYoEpcUoI2hqQp+K9hu0D
         gZBwhTX1M/sDHz6vey2hjQroSf3mcLJhcwbZ5DoYyyUKD5q3nyhlCmBHgXO+wtFpJi3/
         oVM04LZL6qU8ECRKNoGzzBXl3EPUhJCvdfDCPuIo1xu+ybiHuabvuhIKZ3CRIXqD8v/n
         kwd05kOPXjDH8CJsC07oxhe6UK+daO2FciBtR5eWbMZHCO1o8jFh1WuGwkz+c5rfom6X
         /Xcw==
X-Gm-Message-State: ABuFfoih/o9f/rjVlfWduvMMyEH5IY0XzNJR4ZU4R1p1MxA5VCKbqfwq
        3hJYnyAWbNC2o8fd5NxQkWwNZP9J3VDErA==
X-Google-Smtp-Source: ACcGV62+VEQohE6Gggy9ex0YbQlI2cLELpOcMIpW0+d5Sq+v37cFApYiFlEF7RdnhcZkapXxY2ppIg==
X-Received: by 2002:a25:b196:: with SMTP id h22-v6mr16437860ybj.294.1540241193688;
        Mon, 22 Oct 2018 13:46:33 -0700 (PDT)
Received: from [10.177.251.219] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id b66-v6sm5007000ywf.31.2018.10.22.13.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:33 -0700 (PDT)
Subject: Re: [Cocci] New release after 1.0.7?
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes@sipsolutions.net>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 <1536564277.3224.7.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809121214160.31876@hadrien>
 <1536747369.3678.11.camel@sipsolutions.net>
 <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com>
 <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>
 <6e4b8e78-8a10-3987-dbbb-7793e351e355@hauke-m.de>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <87b9fe5e-329e-bc34-17cd-cd94e7d8233a@broadcom.com>
Date:   Mon, 22 Oct 2018 22:46:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6e4b8e78-8a10-3987-dbbb-7793e351e355@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 10/22/2018 9:49 PM, Hauke Mehrtens wrote:
> On 10/22/2018 01:45 PM, Johannes Berg wrote:
>> On Mon, 2018-10-22 at 13:44 +0200, Arend van Spriel wrote:
>>> On 9/12/2018 12:16 PM, Johannes Berg wrote:
>>>> On Wed, 2018-09-12 at 12:14 +0200, Julia Lawall wrote:
>>>>
>>>>>> I see now that the website advertises the 1.0.7 release, however
>>>>>>
>>>>>>  * it's not tagged in git(hub) - all previous releases have a tag
>>>>>>  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
>>>>>>    the website
>>>>>>  * it *looks* like the actual 1.0.7 release was cut from a much newer
>>>>>>    git commit, likely with the fix?
>>>>>
>>>>> There is now a tag for the official release of 1.0.7 in github.
>>>>
>>>> Great, thanks!
>>>
>>> Were you able to build this tag? I probably have dependency issues on
>>> our build server. I tried following the install.txt in coccinelle repo,
>>> but still getting failures. Some hints might be useful. The server runs
>>> ubuntu trusty which is pretty old of course.
>>
>> Hmm. I built something, either that tag or the tarball?
>>
>> johannes
>
> I built the tag on Debian stable successfully, some older versions did
> not build but this tag worked.

That is Debian 9.5 I take it?

Gr. AvS

--
To unsubscribe from this list: send the line "unsubscribe backports" in
