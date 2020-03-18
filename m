Return-Path: <SRS0=zia6=5D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B2C10DCE
	for <backports@archiver.kernel.org>; Wed, 18 Mar 2020 18:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09E72051A
	for <backports@archiver.kernel.org>; Wed, 18 Mar 2020 18:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FpNK2lVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRSNt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:13:49 -0400
Received: from mout.web.de ([212.227.15.3]:43863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgCRSNt (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 18 Mar 2020 14:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584555228;
        bh=kuVcrXVfOJv0W9ObGx9aicM3DFLllyOivWvRf6mIUjc=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=FpNK2lVOhCsPKetN6RVE+c6+ondiUFPMDN1mQje+hZdaJHt7+gsgpvAbDUKAUyXci
         ggfU3DLhm37/1WYMiFNmDFpqrSAqSsu5BSiEo+fJo4xjzmz/WxIXpGt374945ZTwDl
         xKx1v63jM2jvjRY/ZUHa6GKdium/RdS0ykMsLOOA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from christian-ThinkPad.christiansaga.de ([80.133.235.247]) by
 smtp.web.de (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lylol-1jJuDE3l5T-0167nb for <backports@vger.kernel.org>; Wed, 18 Mar 2020
 19:13:47 +0100
Message-ID: <cfdd4be67ee8ff5f6d817182c3115159c76099cb.camel@web.de>
Subject: Makefile patching error in backport from 5.3 to 4.9.214
From:   Christian <list-christian@web.de>
To:     backports@vger.kernel.org
Date:   Wed, 18 Mar 2020 19:13:47 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZvgsVrRfoCuFuC539HYYafS1uFAPVBEqVs+9vRlgCXCVfUjJzWk
 V66nw4fTCY6YMMOYGNLiP+kPm49dNUcJ9aFHvnLRp4++QPnponfXIbZpUDCsWYgu0aqGzyb
 HOOaAHYS7wV+z4SffWziYx3aQ36xsszIXbGJZQuqAmlUsxRfsyaxBB0MFpgQfOL0asrJDkT
 8nFKBDty34urrFNt1lLvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fikq0gr9Dkc=:54bc0yMDr1KbwQY3xmnMWu
 XQq0mOKzS3XzrQMdoqbmQdEMZek65dzfIjq2OW5mAINS7uwOklrwbgza5N4IiUwZUY4sTv1xC
 3ljSwLo81MjZl4TY8WSU7eJbCZ7TT5MSlToSNbIuPCsmze0SCrPgwtQ6cjrSzPWosdEdq1s+1
 qBkUg6C4HYxj05JMNtwkZhwSOHNfJHdjkqRb4zpTeO+Po56rz7uHCWB0FvE8nED8ShNdA67eb
 DTDhMnb0kKTcyUB7fbU3X6KSDyR9PWWyumrjGur6YXTDNzbiuBlHZDRxn3gGehn7ypShblzdf
 EwbIKGtq5cwAHtA3Xlswg6n1xGn5L38iTwnbPFx11umbqrCVhkTwEvk0dn1QjJKvuhPi/eoDg
 LqXBtJ0gFd3TmwdqnXomWF5SnMYyBKqr86tiurcKg5K189ezyr8NEvjh5UKCo1yyr4Ku5UW+r
 3fMhHlqOcPYgo9xxL9mZ14SpewVkE+Xtv+MzWdh33H8nfI4PDlLgdTkmEaJ9xcPtCNXNJoOl3
 3pQKu9kRH52w5J1GKszWGr6Os1qrzALWDR+dIm1JnzpvSRQ1BYziWMOi1D7RP04k7cdCpGgLq
 mrF9zbzME4BnqGvcYeqLXt2UKjHI974rNvdtBLTfvIpbDiqJZ3jxNJIAswNfQnsdkQ8aMEyZj
 6PrLvRkY/yeNEyR+C3WHzO2Em1ZDUMMiEYfe0Xt3F4Q2AMw4ULLxV5w9QICbpZrk46jksqKhs
 7ol6MI68Q40gqka9mF75nV3fj0W45u1ZHVgrJx0Vhs5kGbIFxFBsscO9+6kskOCSPdhH2ICwe
 tBNbPql5gKuhcK07oxsHkL4wn/rspQtfhOfaEJqPtYzhv+BBinVjCSyC3bZQczbV8TmNJ/23G
 OacO0SB5phVyZPvcOpf5N7fMwQf1xBrwl/zPjZyVpqmZIee8yCGgXl0Y20kxJRJscs6jHC+DT
 VYrj6RqH1Yetu9yCb6CojGg55O/ftvCIyLW5XWflHF6wvMghV5JIEW6JvCPByWpbRx7qn9vgy
 YO3RKTPFI/+0d685Rlv8S08jIc7gzLdVX/aQ45gOS0YccSvGPyteKYUxQJ998dfT2o/E8vlOm
 Nqlj+22LAs2MhnWMPrWIiWeYEkCzxTYA5Sjq4yn9Gfw/+UjL5uipaV3OwWzSCwpgDoVrqhnnx
 whs1ntoHAYvbvHs/V8ZQx/q8fPBNCaP96fPuyBJAcxLrfjAaTOV7lyefb8rMtObdNyrzMO5Jt
 IvLZ/sh/s2EoQWnIN
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi there,

I am just trying to backport wireless drivers from 5.3 to 4.9.214. I
thought I start with a clean kernel tree to see how all this works.
However when trying to integrate into a kernel-stable tree, I get an
error when the makefile is to be changed:

Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Applying patches from integration-patches/ to /root/git/linux-stable/
...
Applying patch 001-enable-backports/0001-enable-backports-built-
in.patch
> patching file Makefile
> Hunk #1 succeeded at 571 (offset 29 lines).
> Hunk #2 FAILED at 821.
> Hunk #3 FAILED at 838.
> 2 out of 3 hunks FAILED -- saving rejects to file Makefile.rej

What I did:
cloned linux-stable:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
stable.git -b v4.9.194

cloned linux-next:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
next.git

cloned linux-backports:
git clone
git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git
-b linux-5.3.y

Then used:
./gentree.py --copy-list ./copy-list --verbose --integrate --clean --
git-revision v5.3 ~/linux-next ~/linux-stable

Apparently the patch created by gentree does not fit to the makefile. I
can amend it by hand, however this seems to be an error in the used
patch?
Anyone know what to do?

Kind Regards
Chris

Makefile.rej content:

=2D-- Makefile
+++ Makefile
@@ -821,13 +822,16 @@ core-y		+=3D kernel/ mm/ fs/ ipc/
security/ crypto/ block/

 vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
+		     $(backports-y) $(backports-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m)))

 vmlinux-alldirs	:=3D $(sort $(vmlinux-dirs) $(patsubst
%/,%,$(filter %/, \
 		     $(init-n) $(init-) \
 		     $(core-n) $(core-) $(drivers-n) $(drivers-) \
+		     $(backports-n) $(backports-) \
 		     $(net-n)  $(net-)  $(libs-n)    $(libs-))))

+backports-y	:=3D $(patsubst %/, %/built-in.o, $(backports-y))
 init-y		:=3D $(patsubst %/, %/built-in.o, $(init-y))
 core-y		:=3D $(patsubst %/, %/built-in.o, $(core-y))
 drivers-y	:=3D $(patsubst %/, %/built-in.o, $(drivers-y))
@@ -838,7 +842,7 @@ libs-y		:=3D $(libs-y1) $(libs-y2)

 # Externally visible symbols (used by link-vmlinux.sh)
 export KBUILD_VMLINUX_INIT :=3D $(head-y) $(init-y)
-export KBUILD_VMLINUX_MAIN :=3D $(core-y) $(libs-y) $(drivers-y) $(net-
y)
+export KBUILD_VMLINUX_MAIN :=3D $(core-y) $(libs-y) $(drivers-y) $(net-
y) $(backports-y)
 export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
 # used by scripts/pacmage/Makefile


--
To unsubscribe from this list: send the line "unsubscribe backports" in
