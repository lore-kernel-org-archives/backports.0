Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:62059 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab3ESVAi (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 19 May 2013 17:00:38 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so3873759lab.38
        for <backports@vger.kernel.org>; Sun, 19 May 2013 14:00:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
References: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 19 May 2013 14:00:16 -0700
Message-ID: <CAB=NE6X9sxZzp2ExTc=10QJVgKdsX3iFz483qD5VoHsMewS7fQ@mail.gmail.com> (sfid-20130519_230041_537801_1BC60973)
Subject: Re: [PATCH 0/2] compat: fix compilation for 3.10-rc1 and older
To: Jonas Gorski <jogo@openwrt.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 19, 2013 at 11:47 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> These two patches fix two issues that I encountered/found while
> compiling (a slightly older) compat-drivers against 3.10-rc1:
>
> a) compat-3.10.h was missing an include in the #else branch, causing
>    build failure.
>
> b) random32() was renamed to prandom_u32(), so older kernels were
>    missing an appropriate alias.
>
> Jonas Gorski (2):
>   compat: add missing include in #else for compat-3.10.h
>   compat: handle renaming of random32() to prandom_u32()

Thanks Jonas but for v3.10 we've moved onto a new tree, backports.git:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git

The first v3.10 based release is available for testing:

https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.10-rc1/backports-3.10-rc1-1.tar.bz2

The release page:

http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

The backports tree will have branches for each stable release, so
there is a linux-3.10.y branch on it. Before applying patches to that
branch I will however want code comited on the master branch, and then
refer that sha1sum on the branch.

Please take a look / test and let me know how it goes. Also daily
snapshots are referenced on the release page.

  Luis
