Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C1C3815B
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722A920BED
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 07:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTHuj (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:50:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39538 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTHuj (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 03:50:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jQRCN-00CYus-2f; Mon, 20 Apr 2020 09:50:35 +0200
Message-ID: <4b2da6d05ddf6b4833fefc5706d54062e2e3a573.camel@sipsolutions.net>
Subject: Re: [PATCH 0/8] backports: Update to version 5.6.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Mon, 20 Apr 2020 09:50:34 +0200
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de> (sfid-20200419_191101_353440_75D649E4)
References: <20200419171039.17268-1-hauke@hauke-m.de>
         (sfid-20200419_191101_353440_75D649E4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Sun, 2020-04-19 at 19:10 +0200, Hauke Mehrtens wrote:
> This adds the missing changes to make backports work with kernel 5.6.5
> 

Looks good to me, thanks!

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
