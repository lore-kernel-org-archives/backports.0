Return-Path: <SRS0=vUcr=CQ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB9C433E2
	for <backports@archiver.kernel.org>; Mon,  7 Sep 2020 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AAF2080A
	for <backports@archiver.kernel.org>; Mon,  7 Sep 2020 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUV61KNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgIGQq7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgIGQf1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Sep 2020 12:35:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D4FC061573
        for <backports@vger.kernel.org>; Mon,  7 Sep 2020 09:35:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n25so5857794ljj.4
        for <backports@vger.kernel.org>; Mon, 07 Sep 2020 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+h1Pdc/iqSt3JXpDTI9s9JPO3WZgXFqaBuFfvZnQ5to=;
        b=pUV61KNpQIOkY7p+Dv4ugk6KKi5n5wslOiyFGiYGzu1lbpHNbd0pIa2JTywc2P/dnX
         5IZLa2UoIpYkQ6TizFIUh/oW+45yL9J17AqNDnyJ9Arcqr2istmUJGtM0d7FeJ4tAhS5
         wcLpXGIuaoyENPeDteKnJW8YrfKyGhuacxzyt/J40vg6bTkKaz1cLENRbT/SQO3oUDvf
         /NkKHSOKhdo6hVnhMG2wQ3eYVHdlg7StDNk8xDMT4sjgQ2t+QsO6bVMk2MA0arp67t6Q
         6jcJkb/M2HJniLobN2I5DD/D+HuiW1R5A9HziM5tuZlkRK+PVtzqYhEXCe/586k3VHQp
         Clug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+h1Pdc/iqSt3JXpDTI9s9JPO3WZgXFqaBuFfvZnQ5to=;
        b=E6OUi4IzGCc48YRCilHwwIfdO81bibwsiG9SPg8SUWKBU/+JnWv1V7vSPQzp4GX5zV
         RAmJ67t0ZgO4ej+fYUrnyDYEX02KPJvQq+8gRm+wATR2Q3nSQ2cSLloE3Fg1ZwPA9wTo
         pJMoW8lIbnhPeCmkj+MYcVGf8/sH1vpDICV8QRaoJH4TMaXsh2G+qZtHjUA4i1hFf78Z
         c/+CzLwgc5z/ZeTUm2pBqfBGJ1RsB8SltLehKuBzgdnwkunfwyVzQDmEm1npX4xvkq5e
         Fn2RyWEcM4b8hOx0PNDFYF8UgSwdsAdRY+jefgrWZnhkoCmnkrVO3iiPqcc5gVxFvX+W
         Oq0Q==
X-Gm-Message-State: AOAM530R24WrcZRblhm7v4l3XnYokNjWvMo9ZC4RlG9Kml/p6egtfTj7
        YOV0Oaj0hfhk/ylbGFvRIkJLmYlFzVRmVCpL3a1mh2IE+D8=
X-Google-Smtp-Source: ABdhPJzzRn3lkop2dcVStsN51EY9TXUy9edK7V0jAQbTWLPDb9k90JvZVGq4uOcq6RCTumXkdIukkRKJX9uduDKDm5M=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr3666775lji.406.1599496524537;
 Mon, 07 Sep 2020 09:35:24 -0700 (PDT)
MIME-Version: 1.0
From:   Etienne Cordonnier <cordonnier.etienne@gmail.com>
Date:   Mon, 7 Sep 2020 18:35:13 +0200
Message-ID: <CAJFWPWZRyVuzPy5_vR=2jJRPzG0pXA2hEhpL-sBDmHFLr43Fdw@mail.gmail.com>
Subject: Enabling WEXT_CORE
To:     backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hello,
I am using linux-backports in "integration mode" and managed to
backport wireless drivers from 5.4 to 4.9 (I needed to fix a few
Kconfig files, since integration mode does not work 100% out of the
box, but other than that everything seems to work).

One issue I have is that the file
"patches/0004-disable-wext-kconfig.patch" is removing the option
WEXT_CORE in backports/net/wireless/Kconfig, meaning that there is no
config BACKPORT_WEXT_CORE defined. However the config
BACKPORT_CFG80211_WEXT depends on WEXT_CORE, so I cannot enable
BACKPORT_CFG80211_WEXT and support for the old iwconfig interface (the
iw tool works fine, though). Is it a known limitation, or am I missing
something?

Thanks,
Etienne
--
To unsubscribe from this list: send the line "unsubscribe backports" in
