Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B56C433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 02:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiBDCWR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Feb 2022 21:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiBDCWQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 3 Feb 2022 21:22:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB33C061714
        for <backports@vger.kernel.org>; Thu,  3 Feb 2022 18:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n7p3ps8ETVkIv/hhRuahOhkWNOIzcaPq+sXHsksaVu0=; b=OtWZ81EvCN+KCo5Imeh79isvEm
        eKg4MsN8Wa7WPr1Y0vaU/HRKWkJB1sCPP9O6N+ElAT32w3ZQS4MyC21q52qjftwXsnTSnefiOnoMn
        GPK8Iwr26otYru77rb5Ev/mjj2gqey4BwugKMCjefF9C8r4sFJclxSrg/a5iHonJHRe6/aWviUd5a
        +xvVPYICHKPqX02E7O0v40IOoOZwIUjCXOxfb6bcgdiajw4lKlqvoggz3JZD/P5MC5QWS3l+bGKiR
        RxvCSeP4nY3vu95NyQSySc/rEVsH4bjLkjks19r3Ewe4I6YX6JYcFFM20t+zfy+qrt6NHkFvfbj3/
        qtspsXuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFoEq-003Gnd-26; Fri, 04 Feb 2022 02:22:16 +0000
Date:   Thu, 3 Feb 2022 18:22:16 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     backports <backports@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/7] Resurrect backports Integration Mode
Message-ID: <YfyN2GnfeANyNhaS@bombadil.infradead.org>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
 <YZ5E0B+r0MylLwJw@bombadil.infradead.org>
 <36a7926bc3d5529b0d5f76a28deec840@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a7926bc3d5529b0d5f76a28deec840@adapt-ip.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, Nov 24, 2021 at 08:00:18PM -0800, Thomas Pedersen wrote:
> Hi Luis,
> 
> On 2021-11-24 05:57, Luis Chamberlain wrote:
> > On Tue, Nov 23, 2021 at 09:54:58PM -0800, Thomas Pedersen wrote:
> > > The backports integration mode[0] seems to have suffered some bitrot
> > > and
> > > doesn't currently work. Integration mode can be convenient in certain
> > > use cases and build flows though, so this patch set tries to fixup the
> > > integration mode.
> > > 
> > > These changes were developed and tested for backporting a v5.10
> > > backports + linux branch to a v4.19 kernel. v5.15-rc6 backports +
> > > linux
> > > was successfully built against v4.19.
> > > 
> > > 0:
> > > https://backports.wiki.kernel.org/index.php/Documentation/integration
> > 
> > Good stuff, looks good, just one thing the $FOO --> $(FOO) thing,
> > does that assume/require a bump in kconfig used in backports, ie,
> > if not using integration does that still work? If so then cool,
> > otherwise an upgrade to kconfig would be needed, and if that is
> > going to be done, I have a better solution to bump kconfig soon.
> 
> I just tried the package mode, and no it doesn't work. The embedded kconfig
> doesn't like "$()".
> 
> In that case I'll wait for your changes and resubmit once they've been
> merged.

OK I have kconfig as a git subtree and two trees using it. The main
kconfig tree:

https://github.com/mcgrof/kconfig

Two demos:

https://github.com/mcgrof/init-kconfig
https://github.com/mcgrof/kdevops

Can someone try to convert over backports to it?

First:

git rm -rf backport/kconf/

I think something like the following is needed after that:


diff --git a/backport/Makefile.real b/backport/Makefile.real
index 65508028..1488e117 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -10,36 +10,8 @@ endif
 .SUFFIXES:
 
 export CONFIG_=CPTCFG_
-
-.PHONY: menuconfig
-menuconfig:
-	@$(MAKE) -C kconf mconf
-	@./kconf/mconf Kconfig
-
-.PHONY: listnewconfig oldaskconfig oldconfig \
-	silentoldconfig olddefconfig oldnoconfig \
-	allnoconfig allyesconfig allmodconfig \
-	alldefconfig randconfig
-listnewconfig oldaskconfig oldconfig \
-silentoldconfig olddefconfig oldnoconfig \
-allnoconfig allyesconfig allmodconfig \
-alldefconfig randconfig:
-	@$(MAKE) -C kconf conf
-	@./kconf/conf --$@ Kconfig
-
-.PHONY: usedefconfig
-usedefconfig:
-	@$(MAKE) -C kconf conf
-	@./kconf/conf --defconfig=defconfig Kconfig
-
-.PHONY: savedefconfig
-savedefconfig:
-	@$(MAKE) -C kconf conf
-	@./kconf/conf --savedefconfig=defconfig Kconfig
-
-defconfig-%::
-	@$(MAKE) -C kconf conf
-	@./kconf/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
+export KCONFIG_DIR=$(CURDIR)/scripts/kconf
+include $(KCONFIG_DIR)/kconfig.Makefile
 
 .config:
 	@test -f defconfig && $(MAKE) usedefconfig || (			\

Or just wait to add the code until after the next commits.
Then see this on init-kconfig example:

mcgrof@fulton ~/devel/init-kconfig (git::master)$ cat Makefile.subtrees 
# If you need to use a git subtree, please add it here.
add-kconfig-remote:
	git remote add kconfig https://github.com/mcgrof/kconfig.git

add-kconfig:
	git subtree add --prefix=scripts/kconfig/ kconfig master

refresh-kconfig:
	git fetch kconfig
	git subtree pull --prefix=scripts/kconfig/ kconfig master

The prefix will be differnt for backports, so backport/kconfig/
So you can just run this manually first:

git remote add kconfig https://github.com/mcgrof/kconfig.git
git subtree add --prefix=backport/kconf/ kconfig master

Generate a tree and see if that worked.

> > I'll be making kconfig code stand alone tree soon which projects
> > which want to embrace it can use it as a git subtree (note this
> > is different and better than a git sub module). Then updates
> > can just be done with something like:
> > 
> >   make refresh-kconfig
> > 
> > And that would just get the latest kconfig and trigger a merge commit
> > locally.
> 
> Cool. It seems kconfig is becoming somewhat of a standard for build time
> configuration (backports, u-boot, buildroot, etc.), so it makes sense to
> live as a standalone repo.

Indeed. Hence the above effort. I finally got it. If this works then
we can just sync kconfig once in the kconfig tree and then projects
which use it can just run the refresh target to update.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
