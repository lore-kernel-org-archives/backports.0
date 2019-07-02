Return-Path: <SRS0=rY5T=U7=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB4C5B57D
	for <backports@archiver.kernel.org>; Tue,  2 Jul 2019 07:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1E2146F
	for <backports@archiver.kernel.org>; Tue,  2 Jul 2019 07:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfGBHoj convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:44:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34030 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBHoj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Jul 2019 03:44:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hiDSw-0000GU-5M; Tue, 02 Jul 2019 09:44:38 +0200
Message-ID: <8773b100b12c15a19607ae5381d52fac21bea0e3.camel@sipsolutions.net>
Subject: Re: [PATCH 18/18] header: add support for GCC7 and GCC8
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Tue, 02 Jul 2019 09:44:37 +0200
In-Reply-To: <20190701214914.8066-20-hauke@hauke-m.de> (sfid-20190701_235008_621309_12E7BE1C)
References: <20190701214914.8066-1-hauke@hauke-m.de>
         <20190701214914.8066-20-hauke@hauke-m.de>
         (sfid-20190701_235008_621309_12E7BE1C)
Content-Type: text/plain
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Typo in the subject - gcc8/9, not 7/8

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
