Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA2C433F5
	for <backports@archiver.kernel.org>; Thu, 25 Nov 2021 04:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhKYEFf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 23:05:35 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:47602 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhKYEDd (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 23:03:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 7C7C8744E57;
        Thu, 25 Nov 2021 04:00:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 0iO3rhu219mI; Thu, 25 Nov 2021 04:00:19 +0000 (UTC)
Received: from mail.ibsgaard.io (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 0E0AD744E58;
        Thu, 25 Nov 2021 04:00:18 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 24 Nov 2021 20:00:18 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     backports <backports@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 0/7] Resurrect backports Integration Mode
In-Reply-To: <YZ5E0B+r0MylLwJw@bombadil.infradead.org>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
 <YZ5E0B+r0MylLwJw@bombadil.infradead.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <36a7926bc3d5529b0d5f76a28deec840@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Luis,

On 2021-11-24 05:57, Luis Chamberlain wrote:
> On Tue, Nov 23, 2021 at 09:54:58PM -0800, Thomas Pedersen wrote:
>> The backports integration mode[0] seems to have suffered some bitrot 
>> and
>> doesn't currently work. Integration mode can be convenient in certain
>> use cases and build flows though, so this patch set tries to fixup the
>> integration mode.
>> 
>> These changes were developed and tested for backporting a v5.10
>> backports + linux branch to a v4.19 kernel. v5.15-rc6 backports + 
>> linux
>> was successfully built against v4.19.
>> 
>> 0: 
>> https://backports.wiki.kernel.org/index.php/Documentation/integration
> 
> Good stuff, looks good, just one thing the $FOO --> $(FOO) thing,
> does that assume/require a bump in kconfig used in backports, ie,
> if not using integration does that still work? If so then cool,
> otherwise an upgrade to kconfig would be needed, and if that is
> going to be done, I have a better solution to bump kconfig soon.

I just tried the package mode, and no it doesn't work. The embedded 
kconfig doesn't like "$()".

In that case I'll wait for your changes and resubmit once they've been 
merged.

> I'll be making kconfig code stand alone tree soon which projects
> which want to embrace it can use it as a git subtree (note this
> is different and better than a git sub module). Then updates
> can just be done with something like:
> 
>   make refresh-kconfig
> 
> And that would just get the latest kconfig and trigger a merge commit
> locally.

Cool. It seems kconfig is becoming somewhat of a standard for build time 
configuration (backports, u-boot, buildroot, etc.), so it makes sense to 
live as a standalone repo.

Thanks.

-- 
thomas
--
To unsubscribe from this list: send the line "unsubscribe backports" in
