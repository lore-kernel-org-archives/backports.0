Return-Path: <SRS0=LA5M=NC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D264DC67863
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7494E20658
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TuRY6fiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7494E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJVUCz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:02:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeJVUCz (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Oct 2018 16:02:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so44194309wrt.1
        for <backports@vger.kernel.org>; Mon, 22 Oct 2018 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tZNRsgfI4t9ZItVP9LJMq5Ndgq66zBu/ca1Y25yvKr0=;
        b=TuRY6fiF7nsYrplkev0i6tKYc8iJGkTi3Ryq3GXCYZZ3unicfzOeK3qKnpdd2mX+C/
         F2eGktCevgXyen38/Dupx/s4SjwvBkWJ50hHPjDo/z3huOe9O+kx2GhvfgGeWv0VeGns
         bboRvKkssbE5SLZwsmg6ic/J3FW4vCXwOxxNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tZNRsgfI4t9ZItVP9LJMq5Ndgq66zBu/ca1Y25yvKr0=;
        b=Jz9EMAQtqg1+jDiM4IwbVzjlwgvJE7lyuzp3M+dA1J37oS4W9SpnW6fDhLvT5cqHWu
         W08KIT/GG4RDylfSzrJRVSqSS4cn8Md8otplSxpdQMVjYscT/Ft70E5AG8vsj/9Eaabb
         FfMkceZYzNVMXHGA9ba4nFO8LM4uyQD/ZnymuA7NiGIyt47sjRza+cjPgoDFDDz/Ztto
         e25MFIOL3b7Dnr+YR9wu7QK/6VUzAlgN8pXfmC0stBdePNo7Tts+UejZ1iDWh9C7GkB6
         CCI4OFWoTA1jR6MA/rLYrXppsWwakFjd57ZroLqA+85xC/uQXhxIY8UzHuy6shZyUrGm
         0GNQ==
X-Gm-Message-State: ABuFfoiEaggQMT8efo4gzkg67+EO6uUSxGGeRb3lY6mq/Q8M6jjc+BZX
        TtETqvDcWYBR/yIP9NadaJs8SMfq/qBjbQ==
X-Google-Smtp-Source: ACcGV63tSejBK3ruugczt3wE42Ru5wkYRsWQcpmqMaTGEnEdrqoyZNH63/bT9fidqH6VjYRl/WwiLw==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr43841237wri.139.1540208680738;
        Mon, 22 Oct 2018 04:44:40 -0700 (PDT)
Received: from [10.176.51.60] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h13-v6sm28059578wrr.73.2018.10.22.04.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 04:44:40 -0700 (PDT)
Subject: Re: [Cocci] New release after 1.0.7?
To:     Johannes Berg <johannes@sipsolutions.net>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 <1536564277.3224.7.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809121214160.31876@hadrien>
 <1536747369.3678.11.camel@sipsolutions.net>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com>
Date:   Mon, 22 Oct 2018 13:44:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1536747369.3678.11.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 9/12/2018 12:16 PM, Johannes Berg wrote:
> On Wed, 2018-09-12 at 12:14 +0200, Julia Lawall wrote:
>
>>> I see now that the website advertises the 1.0.7 release, however
>>>
>>>  * it's not tagged in git(hub) - all previous releases have a tag
>>>  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
>>>    the website
>>>  * it *looks* like the actual 1.0.7 release was cut from a much newer
>>>    git commit, likely with the fix?
>>
>> There is now a tag for the official release of 1.0.7 in github.
>
> Great, thanks!

Were you able to build this tag? I probably have dependency issues on 
our build server. I tried following the install.txt in coccinelle repo, 
but still getting failures. Some hints might be useful. The server runs 
ubuntu trusty which is pretty old of course.

Gr. AvS

--
To unsubscribe from this list: send the line "unsubscribe backports" in
