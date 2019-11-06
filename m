Return-Path: <SRS0=uHj9=Y6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A451C5DF63
	for <backports@archiver.kernel.org>; Wed,  6 Nov 2019 22:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447262173E
	for <backports@archiver.kernel.org>; Wed,  6 Nov 2019 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U23jb7Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfKFWDC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:03:02 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34493 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWDB (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Nov 2019 17:03:01 -0500
Received: by mail-pf1-f171.google.com with SMTP id n13so120719pff.1
        for <backports@vger.kernel.org>; Wed, 06 Nov 2019 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yuAbxyisaekvGok6uHnI+F0Eo7a/sIaAylawW0Slnk=;
        b=U23jb7Q2tFFuWs0vonfb95w7pcR0OJXVgAnMs7Njd9aJz6A5/LlqdhencrDiRSVqlT
         DeKYgFuNEZ0iRaD4iy++YFcRcPz6rHgTXc1De1upWIL6kLZxbRUQn73VekDuAlV11DVC
         yyJFxqBAhJ1KhbVAqMsxayJwSL1XtMG0YmVYRjhvt9toC/6UvkmJq9RWizpIyHkH1FNE
         FeAjvS1SnMPieR0iqdhjFc6QzlEhgXw0LuDN3bp1ZnAi8DIHQZrMC44HNvvZ8WyloXDf
         cyDtm9Jqc+iXccKkJ7Sg/FI7LA0YG3jsaK62Y5Jh3uiZbmYM3jVFNQ7ju+4q/3VVeAmK
         B2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yuAbxyisaekvGok6uHnI+F0Eo7a/sIaAylawW0Slnk=;
        b=dP992/A7K7RtS+ujcsaX7horeIuFBkPjd9k7JOwi4TX+jlHaKX4RAsg+VPbtjhZjSY
         K8G1+6ZK5e6Uqcwt6W7IkUAe3wcb/7zfN7UyvOxDdc09zmJfunONIWfUGURjNx/smx3Z
         u8L8/0dsPYB4EgXgjRQTBKdeYBagWRNzpTgosTPnWbExqjzJiu9Gd5YDUQPoA7M0zcjf
         L6vsDpDNNg+EG7s/YLN0Wnyv8eNrqFEcY5Tna2lQUQmStx2hv+KcjqEjSF1KMq2Fn8Yx
         Fhjm0Yvp1WOu67Fg1O4lLIZQiRQmEk9qi/B7lTQSIImTLForWjhNcUgBzT5Z8CCEaP7g
         jcaA==
X-Gm-Message-State: APjAAAXwSK9blASfYwO9f3rwHLtl18tHl0o4VBgUnVSV685XtLHPPDmc
        bj/xAFUf6wCleRjlx/An0F/aXmcxB7y9og==
X-Google-Smtp-Source: APXvYqxVSZIXCuSnKW+aUY9vNoYr461SmX5WGRRJpIqBnHJBJvNG3HO5tPyKy4sy2dngzWjUL0v9HA==
X-Received: by 2002:a17:90a:9a81:: with SMTP id e1mr127952pjp.59.1573077780604;
        Wed, 06 Nov 2019 14:03:00 -0800 (PST)
Received: from dfrey-arch-linux.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id o15sm44915pgn.49.2019.11.06.14.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:02:59 -0800 (PST)
From:   David Frey <dpfrey@gmail.com>
To:     backports@vger.kernel.org
Cc:     David Frey <dpfrey@gmail.com>
Subject: [PATCH] pycocci: fix error when python is python3
Date:   Wed,  6 Nov 2019 14:02:48 -0800
Message-Id: <20191106220248.214650-1-dpfrey@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

When running under an Arch Linux system where python is python3, the
following error was observed:

  Traceback (most recent call last):
    File "/home/dfrey/projects/backports-linux/devel/pycocci", line 172, in <module>
      ret = _main()
    File "/home/dfrey/projects/backports-linux/devel/pycocci", line 158, in _main
      if args.jobs > 0:
  TypeError: '>' not supported between instances of 'NoneType' and 'int'

The problem is that args.jobs is None in the case that the -j or --jobs
argument wasn't passed to the command. In python3, an exception is
generated when performing a comparison between different types.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 devel/pycocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/pycocci b/devel/pycocci
index 4aa1d363..eb072a7d 100755
--- a/devel/pycocci
+++ b/devel/pycocci
@@ -155,7 +155,7 @@ def _main():
     if args.profile_cocci:
         extra_spatch_args.append('--profile')
     jobs = 0
-    if args.jobs > 0:
+    if args.jobs is not None and args.jobs > 0:
         jobs = args.jobs
 
     output = threaded_spatch(args.cocci_file,
-- 
2.23.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
