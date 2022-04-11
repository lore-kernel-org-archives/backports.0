Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873FC43219
	for <backports@archiver.kernel.org>; Mon, 11 Apr 2022 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiDKWCx (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350394AbiDKWCq (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Apr 2022 18:02:46 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C581339
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 15:00:30 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4KcjTS5bYfz9sXS;
        Tue, 12 Apr 2022 00:00:28 +0200 (CEST)
Message-ID: <60cc3552-3bac-ea43-b54f-b6d49945c2da@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649714426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jwrq1CW5AZXoRoa5BID5Agsyn1V83fW7dk7MNq9T+GI=;
        b=VUGerLJNoLvLzttxFEnBkRk0BO1OXeTmEnMRNB7oTk1OStvcDl902caJUkO5+p8oPJLisr
        JKvkrc3d7Cb8UoVxO26ooCi9coJYlE5puaNwIutRYyrm6Oc0u1yiNb5gOjsbj8or5xdOFc
        Vlfxn8FHQIzbjIRYawhGGnEOjbiXiunAMYjw4aDkMzU/MkS81igGaq9pjOUsVFf3sSPopK
        riclTi2M/GOx9u8dbP9g+7UUItR8ptA1TkK4F8/jbjpy5o6IP5oadoYFaBq7unb4dq2JrJ
        A8FRxt/Z754vOJy9za+yNfsrgMPXfYT3IvPe7ucjcl1pRSq/A2qtjlJX7jHfXw==
Date:   Tue, 12 Apr 2022 00:00:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH backports] headers: fix lockdep_assert_not_held()
Content-Language: en-US
To:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Oskari Rauta <oskari.rauta@gmail.com>
References: <20220311194800.452-1-ynezz@true.cz>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220311194800.452-1-ynezz@true.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 3/11/22 20:48, Petr Štetiar wrote:
> LOCK_STATE_HELD define was omitted during backport of
> lockdep_assert_not_held() which leads to build failures of kernels with
> CONFIG_LOCKDEP=y:
> 
>   backports-5.15.8-1/backport-include/linux/lockdep.h:16:47: error: 'LOCK_STATE_HELD' undeclared (first use in this function)
> 
> Fix it by adding missing LOCK_STATE_HELD define.
> 
> References: https://github.com/openwrt/openwrt/pull/9373
> Fixes: af58b27b1b1a ("headers: Add lockdep_assert_not_held()")
> Reported-by: Oskari Rauta <oskari.rauta@gmail.com>
> Signed-off-by: Petr Štetiar <ynezz@true.cz>

Thank you for your patch, I applied it to master.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
