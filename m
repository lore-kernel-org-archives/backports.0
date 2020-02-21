Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63211C35640
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE862071E
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgBUI4d (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:33 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54696 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgBUI4c (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:32 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546o-00EncU-Q2
        for backports@vger.kernel.org; Fri, 21 Feb 2020 09:56:30 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Subject: [PATCH 00/15] updates & improvements
Date:   Fri, 21 Feb 2020 09:56:09 +0100
Message-Id: <20200221085624.6213-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is what we have now to make our driver (only) work on 5.5, and
because I got tired of waiting for the devel/git-tracker.py I threw
in a speed improvement for the gentree --git option, using git's
cat-file --batch API. We should use that for much more, and perhaps
implicitly in the git library, but getting the files was one of the
slower things, now it's barely noticable.

johannes


--
To unsubscribe from this list: send the line "unsubscribe backports" in
