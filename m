Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6609C0032E
	for <backports@archiver.kernel.org>; Fri, 20 Oct 2023 19:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJTTWE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Oct 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJTTWC (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Oct 2023 15:22:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063CBE
        for <backports@vger.kernel.org>; Fri, 20 Oct 2023 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mB7L3nBCn698V+Fg0PUgSA3yc7O6bFlgNejLTandnOo=;
        t=1697829713; x=1699039313; b=Cg7gtcvQdFJAlHmus00D6kNfCMmXbOlFrWkK9N6fldLQOpo
        I8jC17FCtsLrsxcCeIvxP7b1tqAYS2KnRoAeNWaR7zLt8soweg3JmyLXa1IqMmQgKEZD/FNy4oTPZ
        2QbGr+qPQZZEkf2paeqCXOaf5ymS8twpHqkb/jHj6TvCQjkUFdCRIJ2E+n7pbcBakddbvhZdsst6C
        n7cVULSlTkVasgHo7149auSWLajdx3cbYmfJPcviYE+yV0VGqDlu0Ntayntm8Aj+uKgWi1nx9xD57
        pyBEtC+oxPt6NrpgQ3nwCF13m23YseXduS8Uc/xNZgHZjJIx3GlY/9FQhdLd3qhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qtv4A-0000000Ehju-0Ntp;
        Fri, 20 Oct 2023 21:21:50 +0200
Message-ID: <c619a7560214e617094584c5908904a02dedb928.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Witte <brianwitte@mailfence.com>, hauke@hauke-m.de,
        backports@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 20 Oct 2023 21:21:48 +0200
In-Reply-To: <b8e99a7c-4419-400d-bd03-c3389be63760@mailfence.com>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
         <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
         <b8e99a7c-4419-400d-bd03-c3389be63760@mailfence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Brian,

> lwfinger/rtw89 is an out-of-tree backport of the in-tree rtw89. outside
> of documentation, files needed to build/manage the driver, and inserted
> #if #else #endif statements for compatibility. It attempts to be a
> "copy" of the upstream rtw89. there is no new hardware support or
> capabilities built into it as far as I understand.
>=20
> The purpose of this repo shares the same stated goal of Linux Backports
> which is "taking code from newer Linux kernel versions and adapting
> them so they can be compiled and run on older kernel versions."

Right, OK.

> Right now, the main way Larry does this is by filtering new rtw89
> patches out of `wireless-next` and then incrementally applying them
> via a git workflow using quilt and wiggle while applying #if #else
> #endif for the changes between versions.

OK.

> What I am trying to achieve:
> 1. Compatibility that reaches back further. Right now lwfinger/rtw89
> repo only extends back to kernel version 5.7.

We did keep pushing the cut-off for backports, but I think it's at
4.something now? Also, some drivers have a higher cut-off, per the
'dependencies' file. The only RTL thing I see mentioned though is
RTL8723BS with 5.4.

> Ok, I need test this properly with rtw89 and a few different older
> kernels. There were a few things that were unclear to me about how
> backports works that are now more clear.
>=20
> When I check for the rtw89 cards, I see:
>=20
>      $ pwd
>      /home/user/backports/backport/defconfigs
>=20
>      $ cat check_for_rtw89_cards.awk
>      BEGIN { found =3D 0 } # print line
>      if found /8852AE|8851BE|8852BE|8852CE/ {
>          print $0 found =3D 1 exit
>      } END { if (found =3D=3D 0) { print "not found" } }
>=20
>      $ awk -f check_for_rtw89_cards.awk rtlwifi
>      not found

Well not having anything in the defconfig doesn't mean much - we used to
at least try to build _all_ drivers that were possible (i.e. where
dependencies could be satisfied), and "allmodconfig" works here I think.

The copy-list takes all of the drivers under drivers/net/wireless/ (and
even some from staging), so it should be included.

> I will start looking into getting rtw89 running in backports.git if
> my tests show they are not yet supported.

Sure, please do try.

Also if you run into any missing backports let us know - there currently
aren't any not applied yet [1] and there are almost certainly some
integrated into iwlwifi [2] not sent as backports.git patches yet.

[1] https://patchwork.kernel.org/project/backports/list/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwif=
i.git/


> Otherwise, alot of my understanding of how backports work was not
> completely wrong and you made some important clarifications re:
> usage and options that are available re: commit history.
>=20
> So as far as how I can decide what I will do with the lwfinger/rtw89
> repo and others like it entails figuring out the current state of
> these drivers within the Linux backports project and how that can
> fit in with our current users and how we support them.

Makes sense.

> Initially, I was just committed to putting in the work on these drivers
> in their standalone GitHub repos, but it seems like consolidating
> those efforts seems like the best approach if I can make it work.=C2=A0

Yeah, there's probably no good reason to have a repo per driver, doing
effectively the same thing more than once.

> Ok, I am going to start actually running backports against different
> setups to see what I can get a handle on and then follow-up
> accordingly.

Sure.

> If there is anything specific to look into, let me know.

Don't think so.

To get a better feel for how backports works and what all the
transformations look like etc., you can run gentree with --git-debug
command line, then it creates a git tree in the output and tracks there
individual *changes* it makes, for debug. Not to be confused with
tracking the input commits, of course, that's git-tracker's job.

If you do decide to use git-tracker, let me know, I'll check if we have
some additional changes internally to how it handles merges etc. We
might.

Have fun exploring! :-)
And do let us know if you hit any snags.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
