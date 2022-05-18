Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89085C433EF
	for <backports@archiver.kernel.org>; Wed, 18 May 2022 13:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiERN6D (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 18 May 2022 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiERN6B (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 18 May 2022 09:58:01 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 06:57:49 PDT
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B82A76D4
        for <backports@vger.kernel.org>; Wed, 18 May 2022 06:57:49 -0700 (PDT)
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id B210C17E6
        for <backports@vger.kernel.org>; Wed, 18 May 2022 15:52:45 +0200 (CEST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 4D3B12075F.ADC35
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:141:242:ac11:28])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 4D3B12075F;
        Wed, 18 May 2022 15:52:39 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from zbook-mathy (ip-62-235-85-165.dsl.scarlet.be [62.235.85.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 1A604D4EC59BA;
        Wed, 18 May 2022 15:52:39 +0200 (CEST)
Date:   Wed, 18 May 2022 15:52:38 +0200
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     backports@vger.kernel.org
Subject: Re: [PATCHv2] backports: Update hwsim defconfig
Message-ID: <20220518155238.42d1d464@zbook-mathy>
In-Reply-To: <d7f450afc9877b06cba8f5e6b4083b34f0733ef5.camel@sipsolutions.net>
References: <20220411073931.19198-1-Mathy.Vanhoef@kuleuven.be>
 <d7f450afc9877b06cba8f5e6b4083b34f0733ef5.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 11 Apr 2022 09:58:31 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Mon, 2022-04-11 at 15:39 +0800, Mathy Vanhoef wrote:
> > In the current hwsim config no rate control algorithm is enabled.
> > This means that, when using defconfig-hwsim, the mac80211_hwsim
> > fails to load with the following error:
> > 
> > 	[  132.155183] ieee80211 phy0: Failed to select rate
> > control algorithm [  132.155196] ieee80211 phy0: Failed to
> > initialize rate control algorithm
> > 
> > Fix this by enabling rate control algorithms in the provided hwsim
> > config.  
> 
> Makes sense, thanks.
> 
> > Experiments were also less reliable when WEXT was enabled. So this
> > patch also disables WEXT when using defconfig-hwsim to make the
> > default more reliable for users.
> >   
> 
> Huh? How so? Maybe some other tool was present on the system that was
> using wext, and disabling wext made that tool no longer detect the
> wireless or so? I cannot see how else it would be "less reliable" with
> wext enabled, if you don't really use it.

I checked this in more detail: when using kernel 5.13.0-30-generic on
Ubuntu 20.04 with backports-5.15.5-1 the kernel crashes when adding
interfaces in case WEXT has been enabled in backports (in my case when
inserting mac80211_hwsim in a virtual machine). The problem is that
wdev->netdev is NULL inside the function cfg80211_init_wdev, causing
the kernel to hang. The same happens on kernel 5.15.40-1-lts on Arch
Linux (this is currently the most up-to-date LTS kernel on Arch Linux).

Interestingly, on kernel 5.13.0-41-generic on Ubuntu 20.04 this isn't a
problem because the field wdev->netdev is then initialized.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
