Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCBC4332F
	for <backports@archiver.kernel.org>; Mon,  7 Mar 2022 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiCGQ4k (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbiCGQ4i (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Mar 2022 11:56:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A77E0B3
        for <backports@vger.kernel.org>; Mon,  7 Mar 2022 08:55:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so24310919wra.12
        for <backports@vger.kernel.org>; Mon, 07 Mar 2022 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=U7z4tAW4DqoDwH75I24oGDlB4HCyaup10TOpQfqgjgo=;
        b=RYXKvZXzudxfisAlILIAEIDxPOwQ4x6IfofPxeeOoSXxDGUsDgDVdOnfQ/8/L/8GAC
         8F+4neAX0VBEsugFiJmxljWXwiT8taAkU18wpHmP1UOSBqFgpRI1g9K32wa6ITybbLC5
         rQpUUcVM/3Lwwt9HmthnnPsf+/aJI7YDVB3ssHNnZdiQBvzV89c6kQvr9oV3GK34Fj/P
         ATClKHTTMpfy1hFsprf1/x4bF9u84VejEJT9f0wkC7jRVoqRLyOiRdRbq525K9pVdmSo
         NJhqyCo/UJ7DpoTfVoRKHh5WkMmyrM4GT5hZAsQJsWWSDb3sHyEqPQtgvOlmiTz1o/XJ
         f50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U7z4tAW4DqoDwH75I24oGDlB4HCyaup10TOpQfqgjgo=;
        b=Jm/px9TavTpuZ48BbtzFXQSvfvnDNXRDyEVNgDcLfoipm+fsN7GRJ4y+bx+RkjHtf9
         qoC7udVJ929/UM5okMevw2VEj+Q0DiShtavD0KA7NmAtTvD2l7T5CseEKMHWPaRPt7zn
         SwXDINaazRwwA/WFMzacANq5pLHCl60RLYB+3oOJHNGphd2/zasYFcMfn5fLutFpjGvo
         wQkrxBFnvLGWLd5QOP5Yrlv92s4WjH2FfZv36gXeLy5PunqjQ+xTksnzXxIt0NuHTV96
         X6EgzayGzKfJMuGSLujQVkZ47XZoDCb73Tmdh5xRngF2V3XBXCTEqLfYfYaeKCY+7iVp
         U+AQ==
X-Gm-Message-State: AOAM5333D0o3aodZkg8km3RqeUjIqW6CcXXmjOsM+CXroiyH7pdV7cga
        axR7jsszB3sDW6uKuankN2ar4G41IKDT1EZcG4zhpNJmcn8=
X-Google-Smtp-Source: ABdhPJyzemf0BDwkXJHONWEtxs5vMFIflBC/VnPos3jNLG/9W0023Zo6KkI97Gbs8ZxLwKSkwTCMiiJrYSYiM8T4Pb0=
X-Received: by 2002:a05:6000:1567:b0:1fb:768d:7a4 with SMTP id
 7-20020a056000156700b001fb768d07a4mr1949417wrz.185.1646672141267; Mon, 07 Mar
 2022 08:55:41 -0800 (PST)
MIME-Version: 1.0
From:   Joo Yong-Seok <joo.yongseok@gmail.com>
Date:   Mon, 7 Mar 2022 08:55:30 -0800
Message-ID: <CAE3xvfbJudPQa9w5oe-LEjnZSj9CqrMts2jN-a2cmd4Wb+m1TQ@mail.gmail.com>
Subject: Question about backport output generation with linux-4.9
To:     backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi,

I am a newbie on linux-backport and I have a problem generating a
backport output with linux-kernel 4.9.y checkout. These are what I ran
to generate backport output against linux-4.9 kernel.

1) "git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;
git checkout linux-4.9.y"        # linux-stable git repo clone for
source
2) "git clone git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git";
git checkout linux-4.19.y" # linux-backports
3) In backports directory, ran "./gentree --copy-list copy-list
--clean /abs-path/linux-stable /abs-path/output"

I hit many gentree errors like

> File doesn't exists
> Patch error (refcount.c lock, rhashtable related things...)
> Another patch errors

I resolved by removing the patch files and directly modified the
source in linux-4.9 stable repo as well as modified Kconfig file under
backports/compat.
Also, remove files that don't exist.

I am really wondering whether these procedures are the right way to
generate the backport output.
I need to generate mac80211.ko / cfg80211.ko / and wifi-driver.ko
against our linux-4.9 kernel source code to support a lower version of
kernel.

If I checked out linux-5.4.y kernel from linux-stable repo and checked
out linux-5.4.y from backport repo, I don't see these types of errors.
Please advise me.

Thank you.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
