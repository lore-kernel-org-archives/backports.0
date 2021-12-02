Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0ACC433F5
	for <backports@archiver.kernel.org>; Thu,  2 Dec 2021 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhLBTzD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:55:03 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:55964 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbhLBTzC (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 2 Dec 2021 14:55:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1D6E6720255;
        Thu,  2 Dec 2021 19:51:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 63B_7ByF5o_x; Thu,  2 Dec 2021 19:51:36 +0000 (UTC)
Received: from mail.ibsgaard.io (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 6485E7202E5;
        Thu,  2 Dec 2021 19:51:36 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 02 Dec 2021 11:51:35 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports <backports@vger.kernel.org>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@ibsgaard.io>
Subject: Re: [PATCH 1/7] backport: refresh integration patch
In-Reply-To: <f1d3c92d-1532-09ee-5ce2-4d81793c16b7@hauke-m.de>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
 <20211124055505.1267128-2-thomas@adapt-ip.com>
 <f1d3c92d-1532-09ee-5ce2-4d81793c16b7@hauke-m.de>
Message-ID: <cce9ed3163e201df89fe2ee2ddcef429@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Hauke,

Sorry for the late response.

On 2021-11-28 13:50, Hauke Mehrtens wrote:
> On 11/24/21 6:54 AM, Thomas Pedersen wrote:
>> From: Thomas Pedersen <thomas@ibsgaard.io>
>> 
>> This was refreshed on Linux v5-10.42.
> 
> Does this patch still apply with kernel 5.15?

It does not, and in fact the original commit message was a lie.

This patch is applied to the _target_ kernel Makefile (in this case I 
used v4.19.x), so it needs to be versioned against the target kernel 
somehow. Is the target kernel version currently available during the 
gentree stage?

-- 
thomas
--
To unsubscribe from this list: send the line "unsubscribe backports" in
