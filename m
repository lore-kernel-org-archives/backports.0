Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A750C001DF
	for <backports@archiver.kernel.org>; Fri, 20 Oct 2023 16:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJTQmU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJTQmT (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Oct 2023 12:42:19 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53705D61
        for <backports@vger.kernel.org>; Fri, 20 Oct 2023 09:42:16 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 3D176CB5;
        Fri, 20 Oct 2023 18:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697820134;
        s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=5502; bh=VF1gmkEaA+gFRqxWBX0oCdvSfDx+5Npsw5qG1wmvqKY=;
        b=F4YK6RMsaM7hojtDzI+sD5GGm5Zd1TJx7lqvlsgOwfF7voV928EsvaG+ZOVAGsaM
        JOM2Ob94T/LNkUgUtWLFb3BxzPb2lAcea6aWxG02M/3/V+sHpKfPRqmoUCvocT5EHjJ
        twRruCr18chFclBHZzeRyB6lI/zBwCvI7tU/AU8bFQSH692sn5ZNokOO/1SJQHelAqr
        91/4+aiYZvVBfmOfyqh/8lfxaFUgcE09OyJmiN71zBx8sYzsu0WxIagZ62jpDf+jDMK
        eO/bdMsh8QZKuAL7TOPWNOUQBtZXSM970xQ8cJ1N67/OOchsq1kmKZ9EsUHmSnXuyJ9
        434EgbkZiw==
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 20 Oct 2023 18:42:10 +0200 (CEST)
Message-ID: <b8e99a7c-4419-400d-bd03-c3389be63760@mailfence.com>
Date:   Fri, 20 Oct 2023 11:41:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>, hauke@hauke-m.de,
        backports@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
From:   Brian Witte <brianwitte@mailfence.com>
In-Reply-To: <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:441463380
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Johannes,

Thank you for the quick response.

 > Can you explain what you're trying to achieve by that?
 > what is the reason to have these out-of-tree versions of the
 > drivers?

Right, yes. I should clarify that better.

I will use this lwfinger/rtw89 repo as the example throughout this:
https://github.com/lwfinger/rtw89

First, as this caused confusion when Luis first began trying to
assist me:

lwfinger/rtw89 is an out-of-tree backport of the in-tree rtw89. outside
of documentation, files needed to build/manage the driver, and inserted
#if #else #endif statements for compatibility. It attempts to be a
"copy" of the upstream rtw89. there is no new hardware support or
capabilities built into it as far as I understand.

The purpose of this repo shares the same stated goal of Linux Backports
which is "taking code from newer Linux kernel versions and adapting
them so they can be compiled and run on older kernel versions."

Right now, the main way Larry does this is by filtering new rtw89
patches out of `wireless-next` and then incrementally applying them
via a git workflow using quilt and wiggle while applying #if #else
#endif for the changes between versions.

What I am trying to achieve:
1. Compatibility that reaches back further. Right now lwfinger/rtw89
repo only extends back to kernel version 5.7.
2. Ensure that users who visit the lwfinger/rtw89 GitHub page can
get their driver working if they are having issues.
3. Ease the burden of maintaining a backport manually.


 > The backports project doesn't in itself work with out-of-tree
 > drivers.
 > It _creates_ out-of-tree drivers, yes, but it takes the
 > source of these
 > always from the latest upstream kernel.

Right. yes. I understand.

 >   2) these are just used to provide newer drivers to users of
 >      older kernels

Yes, this is the main goal.

Ok, I need test this properly with rtw89 and a few different older
kernels. There were a few things that were unclear to me about how
backports works that are now more clear.

When I check for the rtw89 cards, I see:

     $ pwd
     /home/user/backports/backport/defconfigs

     $ cat check_for_rtw89_cards.awk
     BEGIN { found = 0 } # print line
     if found /8852AE|8851BE|8852BE|8852CE/ {
         print $0 found = 1 exit
     } END { if (found == 0) { print "not found" } }

     $ awk -f check_for_rtw89_cards.awk rtlwifi
     not found

I will start looking into getting rtw89 running in backports.git if
my tests show they are not yet supported.

Otherwise, alot of my understanding of how backports work was not
completely wrong and you made some important clarifications re:
usage and options that are available re: commit history.

So as far as how I can decide what I will do with the lwfinger/rtw89
repo and others like it entails figuring out the current state of
these drivers within the Linux backports project and how that can
fit in with our current users and how we support them.

Initially, I was just committed to putting in the work on these drivers
in their standalone GitHub repos, but it seems like consolidating
those efforts seems like the best approach if I can make it work. At
the end of the day, the lwfinger/rtw89 repo helps alot of people run
Linux that otherwise would not be able to so that is a big factor. But
now that you have clarified and reinforced a few key points, I am
more optimistic that I can figure something out.

 > Yes, pretty much. It'd require someone actually maintaining backports
 > more reliably and creating packages though :)

 > Depends how much work you want to put in? I think what'd help most
 > now would be to actually have someone to do what Hauke used to do,
 > which
 > was integrating patches from the list (and we'd probably have more of
 > them), and creating releases.

Ok, I am going to start actually running backports against different
setups to see what I can get a handle on and then follow-up
accordingly.

If there is anything specific to look into, let me know.

 > That's tricky, I don't think there's a good way to leverage that
 >directly. Also, backports tries to _minimize_ the ifdefs needed in
 >favour of providing spatches and API changes.
 >
 > Also, looking at the rtw89 repo, I notice that it _only_ contains the
 > driver and attempts to make it compatible with all mac80211 versions,
 > which we had previously though of as basically a losing proposition,

Ok, noted.

 > As long as you don't think of "backport outputs a tarball", I think
 > you
 > can see a lot of choices, although not all of them will preserve a
 > patch-by-patch history of the driver.

Right, yes.

Overall, there are few things to think about and there are a few
paths forward. The GitHub repos above and backports.git serve the
same purpose from a technical perspective, but differ with respect
to their distribution, installation, and capabilities (backports.git
more compatibility re: older kernel versions).

With that said, backports.git obviously can't fit any sort of
prescriptive support or installation model that I concoct to fit in
with how those GitHub repos and their users do things, but beginning
to figure out how those repos can be "downstream" of backports.git
and how that might work is a good thing to explore.

 > Given that nobody really seems to have much time to spend on the
 > backports project ... I think that'd be up to you.

Ok, understood.

Thank you,
Brian Witte

--
To unsubscribe from this list: send the line "unsubscribe backports" in
