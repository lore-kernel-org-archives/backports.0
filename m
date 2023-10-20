Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9243C001DF
	for <backports@archiver.kernel.org>; Fri, 20 Oct 2023 02:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjJTC0a (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 19 Oct 2023 22:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJTC03 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Oct 2023 22:26:29 -0400
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 19:26:26 PDT
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDC115
        for <backports@vger.kernel.org>; Thu, 19 Oct 2023 19:26:25 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 2DD05A0E;
        Fri, 20 Oct 2023 04:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697768284;
        s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type:Content-Transfer-Encoding;
        l=7395; bh=qz4CB0TgCibphVPj/5rTARslcsoYjOldV4QTtRRjVwk=;
        b=Q+82uNDWGJ6g0Oq3vVsJzagzdV+UXSoTMfDm24H5/WXRnOcYq+sb6oSfWOQnrPMC
        rg+89ZbwFyMvcQthYfyeLO/CN6WJGOd7BoEBz+taaNvudSJdZ1lmUHZcgU4foLIyCZQ
        3LfbyhjTt7x8R/v0qW+TM+fJkjdA12PVR/frBgG4zmXGotl17fiv8ZHZ/h+VoQAmEmN
        w08PloNaKQO1HY6o+OY2gHFeqmdJRMmarpHg213uYKK5fLYQYSIMue7HcL1e9B43g8a
        DeSOYMl/jphJ1XqLJpRPgdasdWbhzDPCCHbU0X3Ip9eaA16qmAImwlMDeNDWRjkqXEu
        mvGGISU5Kw==
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 20 Oct 2023 04:17:58 +0200 (CEST)
Message-ID: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
Date:   Thu, 19 Oct 2023 21:17:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     hauke@hauke-m.de, johannes@sipsolutions.net,
        backports@vger.kernel.org
From:   Brian Witte <brianwitte@mailfence.com>
Subject: rtw88, rtw89 -- options for bringing a couple rtw standalone GitHub
 repos into backports.git
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:441463380
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hauke, Johannes, or any other backports users/developers,

I recently spoke to Luis Chamberlain about a few different things 
related my new shared maintainership of rtw,rtl drivers on GitHub that 
are under Larry Finger's account:

https://github.com/lwfinger?tab=repositories

The main thing I wanted to discuss is related to the sustainability, 
longevity, and utility of maintaining a few in-tree, standalone manual 
(#if #else #endif) backports for realtek:

https://github.com/lwfinger/rtw88
https://github.com/lwfinger/rtw89

If you want to see where Larry introduces me, it's here:
https://github.com/lwfinger/rtw88/issues/151#issuecomment-1604503581

I just wanted to reach out about these repos and the options and 
tradeoffs with porting them over to the backports.git project in a way 
that will benefit the larger community and our existing users.

I am able to begin the work on these drivers if we decide to try and 
merge them into backports.git, but I need to understand a few things 
since my understanding is often the biggest limitation in all of this.

On more than one occasion, I have gotten confused about how Linux 
backports does things so I want to make sure I am making the right 
assumptions about how it works with respect to commit history and a few 
other things for their respective drivers.

My current understanding re: commit history is as follows:

The main Linux backports project does not preserve the commit history of 
individual drivers as they exist in their original trees that they are 
taken from. The main goal of the backports project is taking code from 
newer Linux kernel versions and adapting them so they can be compiled 
and run on older kernel versions. This backporting process is automated 
by applying a series of patches to make the newer code compatible with 
the older kernel via automation defined in the backports.git repo 
through Makefile, Kconfig, dependent .c or .h files, etc. and of course 
the "semantic patch language" scripts of coccinelle.

Because the goal is to make new code work with old kernels, rather than 
to maintain a faithful, version-controlled history of that code, the 
commit history for individual drivers is not included in project's 
focus. The version control history in the backports.git repository 
serves to track changes to the backporting process itself, rather than 
to preserve the history of the backported code (I know that may be 
obvious, but I need to make sure I am not mistaken.)

In a nutshell, the Linux backports project is geared towards 
compatibility and functionality, not towards historical preservation of 
codebase evolution.

The second thing I want to make sure I understand is how users can get 
backports for a driver via the Linux backports project:

A happy path would look like them pulling down a tar of backports for 
their kernel version from 
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/ and 
then running something like:

```sh
# as a user
make defconfig-rtlwifi
make -j4
# as root
make install
# reboot and enjoy
```

If a feature they need is not in a stable version, they will then have 
to execute a small series of extra steps to compile their own backports 
release and then use that; whether it's against linux-next or some other 
tree. This is a documented and relatively well-traveled path in kernel 
developer terms, but is likely out of reach for many "regular" users. I 
think it is fair to say that this would require them to be a closer to a 
"developer" or experienced Linux user or administrator. They also may 
not know about or be able to find the docs for doing so. A GitHub repo 
with their device driver name is often what they find first.

The last thing I want to make sure I have straight is the value of 
backports.git for wireless drivers generally because there seem to be many:

For maintainers/developers, backports.git offers a standardized, 
automated system that minimizes errors, streamlines many aspects of 
building, testing, and iterating, and allows for community-vetted (more 
eyes), secure code. This centralization frees maintainers to focus on 
other development priorities like fixing/reproducing bugs and landing 
patches upstream.

For users, backports.git provides a stable way to access these new 
features and fixes. It also can be quite simple if you have the right 
kernel version, it lines up with the feature you need, or you have the 
requisite experience and can find then dive into more "developer-like" 
documentation.

For the community, integrating the drivers into backports.git holds 
benefits for downstream projects like OpenWrt, which already rely on 
backports as a core design feature. Therefore OpenWrt and similar 
projects can more seamlessly and securely include them in their 
distributions, enhancing both device support and the end-user 
experience. In addition, the upstream drivers benefit due to increased 
visibility and accessibility, encouraging wider community engagement for 
testing, bug reporting, and code contributions.

This approach serves to unify efforts, improve security, and facilitate 
a solid, shared pipeline for maintainers, users, and the larger community.

In conclusion, there are a few questions I am trying to answer for 
myself, but could use any feedback on.

1. How critical is the preservation of commit history for effective 
debugging and bisecting when issues arise in the backported drivers? We 
have the commit history in our GitHub repos, but they would not be 
present in drivers compiled from backports.git. Is there a way to have 
"the best of both worlds" or mitigate the effects of lacking that history?

2. Are there methods to automate or simplify the process for users who 
need features not yet available in stable releases, to reduce the skill 
barrier?

3. How can I help the backports project directly (rtw related or not)?

4. How can we best leverage the years of effort and modifications (#if 
#else #endif macros) made by Larry in these stand-alone repositories to 
inform the technical work of porting them to the shared backports framework?

5. Given the popularity and visibility of the rtw88 and rtw89 GitHub 
repositories, as indicated by their star counts, issue activity, and 
search engine ranking, what strategies can we employ to maintain this 
level of user engagement and support if we transition to backports.git? 
Would mirroring the code and providing custom-tailored instructions in 
the READMEs serve dual purposes of user support and elevating the 
visibility of backports.git in the larger community? Is this a welcomed 
proposition?

I understand that many of these questions ultimately require hands-on 
work and investigation on my part. However, I believe now is an 
opportune time to engage the community in these discussions.

I will be attending the Linux Plumbers Conference next month on behalf 
of Larry and myself and would like to use this as a start to further 
explore potential collaborations and conversations around these topics.

Lastly, I want to thank the backports.git maintainers for providing an 
invaluable tool for the Linux community. Also, thank you Luis for 
getting me started on having these conversations.

Thank you for your time, and I look forward to future discussions.

Thanks,
Brian Witte
--
To unsubscribe from this list: send the line "unsubscribe backports" in
