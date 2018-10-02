Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3914C64EB8
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93815206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93815206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJCCHB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:07:01 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48258 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJCCHB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:07:01 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QFC-0004cI-Pt
        for backports@vger.kernel.org; Tue, 02 Oct 2018 21:22:06 +0200
Message-ID: <1538508115.3126.50.camel@sipsolutions.net>
Subject: list archive
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 02 Oct 2018 21:21:55 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi all,

Thanks to Konstantin and kernel.org, there's now a public-inbox archive
of this list at https://lore.kernel.org/backports/.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
