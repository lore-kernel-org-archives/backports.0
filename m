Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776AC433EF
	for <backports@archiver.kernel.org>; Wed, 20 Oct 2021 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E69610C8
	for <backports@archiver.kernel.org>; Wed, 20 Oct 2021 20:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJTUL2 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJTUL1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 20 Oct 2021 16:11:27 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D2C06161C
        for <backports@vger.kernel.org>; Wed, 20 Oct 2021 13:09:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i189so26228254ioa.1
        for <backports@vger.kernel.org>; Wed, 20 Oct 2021 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSdiHESLc4dU0U9Ve+EGXlRvCCadrHdlpEc86lmGOB4=;
        b=6KsMUWxRW0FjyFqT4m+7ZrNgoDqumV91Dd6gkgaPIMhxgwXspzK4ZULEQxFQY4W2pp
         xkHU2lJMyQh5CA7Plug/Z42Z6K2zBgEu7igA68/v7+dd0cOhoKVtOe/oLoodD00YVN97
         7tgyAq+sjaTuK1alncUnJM3/04UJTrf7OaoP5lqx2m463hH+6UrJcgYgUHDCXsUE0JaD
         GCFppQbqYhGIGn/KrDGjYSOJ/120KXnRox+hPzqML/I+3Mqksm29H1iuOTG0BbDWUyM6
         LpiFoDRyI6wM8u3nit7Oqn3zwRXnqcp7OzsXvszrm2XDZYD9phzc7A/c1yR6hKAxhp3n
         oQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSdiHESLc4dU0U9Ve+EGXlRvCCadrHdlpEc86lmGOB4=;
        b=gP0WKPKEwn3uhuJjOdlVc/7VVgqP0X2PvVDONGjOb8AACI76gBfeQntIUAhon2pLyF
         yKmSthrEI0fJV5oxlDpdwVBzhCfmmeR/z6ks62bNJSHwYRUlKhSRFIKFTAa05WiiIXTD
         xVtSC3yXvw1MQ0XMKa7axKRsdeFI2ObU3zrLNJalQxB3pWvuRsqm7fPyDnoiopna2Ywr
         WHKeZBwYHhZtTVZOs/ViVgeEotrMCxnd1caKhc7XoaQ3KtwqNPzmy/Tg4ycTsh79IZa0
         JY/CsFtHE51c4MwHce0H0NVp6Zdlhvcm+H+Vl3DiyiiMZxcSB0gNIkDpMxWfM5xz3hmM
         iaYg==
X-Gm-Message-State: AOAM531re+Enzur7oEiUNOmDVSuqWqqXPdTz05pYBbKs/kK6q0EfVULN
        ztEXQj26n6R4boaR6E1rCQT7AzQJNgLtOYHaUu13pTAXSkw=
X-Google-Smtp-Source: ABdhPJxtSfGbLJqtihikBXx/ndDX28JO021M8ZTD2DdAnZR+y4F4hp03Ocwul658p+vAwh0l41CA8aOUadhMBnyboAI=
X-Received: by 2002:a6b:cd8b:: with SMTP id d133mr975176iog.88.1634760551998;
 Wed, 20 Oct 2021 13:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211019214320.2035704-1-hauke@hauke-m.de> <CAFED-jmVY-cWa3FQW2FMj89wvyazxuEzsNtCe5V_v9BvDWj71Q@mail.gmail.com>
 <4bd68122-7db6-7860-7ac4-9bac9508e866@hauke-m.de>
In-Reply-To: <4bd68122-7db6-7860-7ac4-9bac9508e866@hauke-m.de>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 20 Oct 2021 22:09:01 +0200
Message-ID: <CA+HBbNEYLn+n4rB1eXNjNK-nmoik9NpkJBhrzz2g2OWL1=TEBA@mail.gmail.com>
Subject: Re: [PATCH 00/47] backports: Update to kernel 5.15-rc6
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, Oct 20, 2021 at 8:27 PM Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
> On 10/20/21 2:22 PM, Janusz Dziedzic wrote:
> > wt., 19 pa=C5=BA 2021 o 23:44 Hauke Mehrtens <hauke@hauke-m.de> napisa=
=C5=82(a):
> >>
> >> This updates backports to kernel 5.15-rc6.
> >>
> >> This is done in multiple steps, I plan to make a release based on the
> >> latest stable version for each major kernel version between 5.10 and
> >> 5.15-rc6. This was compile tested against kernel 4.4 till 5.10 and
> >> runtime tested in AP mode with ath9k. We want to use this in OpenWrt a=
nd
> >> are testing this in OpenWrt now.
> >>
> >> These patches are also available here:
> >> https://github.com/hauke/backports/tree/devel-5.15-2
> >>
> > Thanks!
> >
> > Could you also share openwrt branch that using this backports.
> > I already have ath9k/10k/11k (PCI) cards could check.
> >
> > BR
> > Janusz
>
> Hi,
>
> I have a feature branch with the patches here:
> https://git.openwrt.org/?p=3Dopenwrt/staging/hauke.git;a=3Dshortlog;h=3Dr=
efs/heads/mac80211-5.15
>
> There are still some problems with ath11k, Robert Marko is working on
> that. ath11k needs some more changes in other frameworks.

ath11k is a pain as its PCI support depends on MHI and QRTR support.
Both of which have things that must be backported in order to kind of work.

I hope to have the ath11k support cleaned up soon so that it can be
sent at least for the PCI variant
after 5.15 backports get merged.

Regards,
Robert
>
> Hauke



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
--
To unsubscribe from this list: send the line "unsubscribe backports" in
