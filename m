Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E44C11F67
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F786140D
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhGAVsl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:48:41 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:43766 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhGAVsk (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 1 Jul 2021 17:48:40 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 17:48:40 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2E3E722431F
        for <backports@vger.kernel.org>; Thu,  1 Jul 2021 21:40:52 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 28B962A006D;
        Thu,  1 Jul 2021 21:40:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D1B1A900066;
        Thu,  1 Jul 2021 21:40:50 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4393F13C2B1;
        Thu,  1 Jul 2021 14:40:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4393F13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625175650;
        bh=/5Ogp3Wen4bQhvgDGDW3sGPBhFss312nJkt2NWpNNL0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pRGQiuaRZcCW0M5oedMtB2n08W4GpOkkV7T322WdAjM3hm65MTamZNAsJLi4McN2d
         fmA7t++58kg7yGi9dN9sUicgaLV+eHi6AdiJdXMkeYyIk7wB1cwMnhXW+8GY/Qj3rc
         IcOgdOug36CWZ1QrDVHKr0y6qgr3AXA4mJQInkms=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
Date:   Thu, 1 Jul 2021 14:40:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1625175651-QCkJYwv5GCzw
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/1/21 2:40 PM, Johannes Berg wrote:
> On Thu, 2021-07-01 at 14:39 -0700, Ben Greear wrote:
>> Hello,
>>
>> I'm trying to get backports to work against my 5.13 kernel.  I'm executing
>> this attempt on a Fedora-34 system, freshly updated.
>>
>> I am stuck on an spatch thing:
>>
>> [greearb@v-f34-64 backports]$ mkdir /tmp/x
>> [greearb@v-f34-64 backports]$ spatch --sp-file patches/0049-no-pfmemalloc/no-pfmemalloc.cocci --dir /tmp/x
>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>> minus: parse error:
>>     File "patches/0049-no-pfmemalloc/no-pfmemalloc.cocci", line 7, column 4, charpos = 90
>>     around = 'page_is_pfmemalloc',
>>     whole content =  || page_is_pfmemalloc(page)
>>
>>
>> [greearb@v-f34-64 backports]$ cat patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
>> @r1@
>> struct page *page;
>> expression E1;
>> @@
>>    return E1
>> +#if LINUX_VERSION_IS_GEQ(3,6,0)
>>    || page_is_pfmemalloc(page)
>> +#endif /* if LINUX_VERSION_IS_GEQ(3,6,0) */
>>    ;
>>
>>
>> Any idea how to fix this?
> 
> What's your spatch version on that system?
> 
> johannes
> 

[greearb@v-f34-64 backports]$ spatch --version
spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking 
--prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 
--libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 
--with-menhir=/usr/bin/menhir
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE
[greearb@v-f34-64 backports]$


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
