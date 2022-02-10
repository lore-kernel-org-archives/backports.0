Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC08C433F5
	for <backports@archiver.kernel.org>; Thu, 10 Feb 2022 14:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbiBJOFp (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:05:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242612AbiBJOFp (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 10 Feb 2022 09:05:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795661FB
        for <backports@vger.kernel.org>; Thu, 10 Feb 2022 06:05:46 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6577C32005BC;
        Thu, 10 Feb 2022 09:05:43 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 10 Feb 2022 09:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=F52dgPpFO2IxOG
        DNHIItZjEizHutrpPqhXvM0oKr0io=; b=qzvH9ZFLtxu96sSrGKNB8TTOtickKU
        iyHrJ+4lKdbMja1Wu+YPPVojwEt980t4er9FIvHiWjf6Aamy/DsRIUsh5l75qxn+
        p+JX81q5y5yfW2fAuDWCaRqJLidmuqUgXnA2FK4gkzLs3JSTjF0yKCPqIs5enwUc
        dEsYLz6CdzRiw3WyprFouW44fuBZ8laUtG/9ApZ3kpnWO8EtnK6GstrZri5E5C7f
        D1961MD0wOuqku7RB4tsp1c/ZwXU7+z75qRK9XQgMGDh/lz1PFA+3pmnIxq6NOYh
        PTbLfs3FQbSaXccN0Gevqjwq5lY9EkxkRyID32TXd1IjKvFMytgGL0jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=F52dgPpFO2IxOGDNHIItZjEizHutrpPqhXvM0oKr0io=; b=KxrGsJOk
        qUA96Eh3yuE2viFt+1pDvcj/ssicMQVcpFDAu/+a5Al9j4AwC3n6Cws1YCbU0wPl
        mf0jPbK77zmHWBHCWyHQ0LesH4xjERSihfOWFPaK+KFrX9k83G/fPJssEy9fjtYk
        PICaUr2l/eY0CVpCpBEDpr9JDeD8IUfzJoiCMfA53sezKo875X3Bm6sApBJghJC0
        Cs5il/yVfDZmaj4TLP7NDfKjSfO2jr5XhrAYNhO3HbE9qbJKshyNveePF1LcF0K1
        b64KTbycwkz+MrQ4Or4WBdTceMaSrmGVJAdCFw6OoReljqKRXPMz97tI4DO8b2vP
        gwcj3aMK+63oUg==
X-ME-Sender: <xms:sBsFYviNTgTOup7c0N4wp50fkjRDpIJIJkGF4vEwQUjLOydCEF9ekg>
    <xme:sBsFYsBelaEUfWQJRrMH1kZL5pDVe5m1x97O6lJrICCIKyJ0llvF8ZGU0C-aTdq-D
    xLvosEOtYxRmRfhTbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sBsFYvEvGtBQP5ZsQQyh9UiN_lzt12VBJPVZsQfHVTuztsPsoLBijQ>
    <xmx:sBsFYsRbSJc_aL5m7WR2gO7PjG_YnPxKElihN_Nh7R0vndxpqIhpvw>
    <xmx:sBsFYszuNDlkhVWeoNMYkOqlE8m4wc2BuSj14vXaGmqz00nP9Y3y7Q>
    <xmx:thsFYib6SNyuLCnOnECNigGW9ysiZo_Bb2OQFtojFuTkB2S04IoVtQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 221BBFA0AA6; Thu, 10 Feb 2022 09:05:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <64e20adf-b959-414f-8104-728ea8d23f76@www.fastmail.com>
In-Reply-To: <7c1fd2554ae907eded15dd247bbda5bc5c28cbe7.camel@sipsolutions.net>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
 <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
 <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
 <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
 <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
 <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
 <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
 <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
 <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
 <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
 <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
 <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
 <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
 <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
 <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
 <7c1fd2554ae907eded15dd247bbda5bc5c28cbe7.camel@sipsolutions.net>
Date:   Thu, 10 Feb 2022 14:05:09 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        "Hauke Mehrtens" <hauke@hauke-m.de>, backports@vger.kernel.org
Subject: Re: Dealing with SUBLEVEL overflow in backports
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



=E5=9C=A82022=E5=B9=B42=E6=9C=8810=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8A=E5=
=8D=888:17=EF=BC=8CJohannes Berg=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2022-02-10 at 00:44 +0100, Hauke Mehrtens wrote:
>>=20
>> What build problem do you get when you include "#include <linux/bug.h=
>"=20
>> here on kernel 4.9.299?
>>=20
>
> I haven't tried, but per the explanation, you get issues if you tried =
to
> include bug.h in the first place, since then you get
>
> bug.h
> -> includes build_bug.h (since the patch)
> -> uses build_bug.h from backports
> -> includes bug.h (does nothing, double include)
>

Yep that's the problem.

What I'm trying is something like:
Though it won't work in kernel intergration mode. My makefile foo does n=
ot
allow me to come up a idea.

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 65508028..26482e52 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -83,8 +83,19 @@ backport-include/backport/autoconf.h: .config Kconfig=
.versions Kconfig.kernel
        ) > backport-include/backport/autoconf.h
        @echo " done."
=20
+.PHONY: backport-include/backport/version.h
+backport-include/backport/version.h:
+       @echo -n "Building backport-include/backport/version.h ..."
+       @echo "#ifndef COMPAT_VERSION_INCLUDED" > $@
+       @echo "#define COMPAT_VERSION_INCLUDED" >> $@
+       @echo '#define COMPAT_LINUX_VERSION $(VERSION)' >> $@
+       @echo '#define COMPAT_LINUX_PATCHLEVEL $(PATCHLEVEL)' >> $@
+       @echo '#define COMPAT_LINUX_SUBLEVEL $(SUBLEVEL)' >> $@
+       @echo "#endif" >> $@
+       @echo " done."
+
 .PHONY: modules
-modules: backport-include/backport/autoconf.h
+modules: backport-include/backport/autoconf.h backport-include/backport=
/version.h
        @$(MAKE) -f Makefile.build modules
=20
 .PHONY: install
diff --git a/backport/backport-include/linux/version.h b/backport/backpo=
rt-include/linux/version.h
index 2cb601ad..06684ffa 100644
--- a/backport/backport-include/linux/version.h
+++ b/backport/backport-include/linux/version.h
@@ -1,5 +1,7 @@
 #ifndef _BP_LINUX_VERSION_H
 #define _BP_LINUX_VERSION_H
+
+#include <backport/version.h>
 #include_next <linux/version.h>
=20
 #ifndef RHEL_RELEASE_VERSION
@@ -10,8 +12,17 @@
 #define RHEL_RELEASE_CODE 0
 #endif
=20
-#define LINUX_VERSION_IS_LESS(x1,x2,x3)        (LINUX_VERSION_CODE < KE=
RNEL_VERSION(x1,x2,x3))
-#define LINUX_VERSION_IS_GEQ(x1,x2,x3) (LINUX_VERSION_CODE >=3D KERNEL_=
VERSION(x1,x2,x3))
+#define COMPACT_KERNEL_VERSION(a,b,c) (((a) << 24) + ((b) << 16) + (c))
+
+#define COMPACT_LINUX_VERSION_CODE                       \
+       COMPACT_KERNEL_VERSION(COMPAT_LINUX_VERSION,     \
+                               COMPAT_LINUX_PATCHLEVEL, \
+                               COMPAT_LINUX_SUBLEVEL)
+
+#define LINUX_VERSION_IS_LESS(x1,x2,x3)        \
+       (COMPACT_LINUX_VERSION_CODE < COMPACT_KERNEL_VERSION(x1,x2,x3))
+#define LINUX_VERSION_IS_GEQ(x1,x2,x3) \
+       (COMPACT_LINUX_VERSION_CODE >=3D COMPACT_KERNEL_VERSION(x1,x2,x3=
))
 #define LINUX_VERSION_IN_RANGE(x1,x2,x3, y1,y2,y3) \
        (LINUX_VERSION_IS_GEQ(x1,x2,x3) && LINUX_VERSION_IS_LESS(y1,y2,y=
3))
 #endif /* _BP_LINUX_VERSION_H */

[...]
--=20
- Jiaxun
--
To unsubscribe from this list: send the line "unsubscribe backports" in
