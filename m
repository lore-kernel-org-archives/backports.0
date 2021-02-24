Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E9C433E0
	for <backports@archiver.kernel.org>; Wed, 24 Feb 2021 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE560238
	for <backports@archiver.kernel.org>; Wed, 24 Feb 2021 12:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhBXMOT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Feb 2021 07:14:19 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:51872 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhBXMOS (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Feb 2021 07:14:18 -0500
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A5E3480F9;
        Wed, 24 Feb 2021 04:13:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A5E3480F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1614168797;
        bh=caqjs/i2r7LKN68Bc/uXrmzYijTbQYX35B5IXyGRpyQ=;
        h=To:Cc:From:Subject:Date:From;
        b=dFB5C3xiX5C+lXySb2BGAwglxYapDBJKAaybrkVB1l2PAhL+be1eh7X/EheiCkCmZ
         vZCR7rS6FzFQUshv8iZfHg0p6LilTpS5RL1mtFK4AB/AYpoja189CI2Edn5f/S3vOX
         Wm2BXqIZPckqzlsBQgCMym0djVDAL+WQPjN1aqiQ=
Received: from [10.230.42.155] (unknown [10.230.42.155])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 7415C187289;
        Wed, 24 Feb 2021 04:13:16 -0800 (PST)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     backports@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: backports Kconfig processing
Message-ID: <a3926220-cc2c-5feb-0017-bf8793184cea@broadcom.com>
Date:   Wed, 24 Feb 2021 13:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Johannes,

I was made aware that the select line in brcm80211 Kconfig is not 
working in backports:

select WANT_DEV_COREDUMP if BRCMFMAC

Is this something that can be fixed in backports?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
