Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35056 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901AbbBILGA (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 9 Feb 2015 06:06:00 -0500
Message-ID: <1423479952.2110.10.camel@sipsolutions.net> (sfid-20150209_120602_758546_76E0CC41)
Subject: Re: [PATCH] backports: add IFF_TX_SKB_SHARING
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Mon, 09 Feb 2015 12:05:52 +0100
In-Reply-To: <54D665E1.5070507@hauke-m.de>
References: <1422638090-20059-1-git-send-email-johannes@sipsolutions.net>
	 <54D665E1.5070507@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2015-02-07 at 20:22 +0100, Hauke Mehrtens wrote:
> On 01/30/2015 06:14 PM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > This was introduced on kernel version 3.1, so a kernel (3.0) without
> > it is still just within the support window. Define this constant if
> > it isn't defined.
> 
> IFF_TX_SKB_SHARING was already added in long time ago and this patches
> doe snot apply on top of current backports.

Hm. What's the correct tree? I don't see it as of commit
6c73549254cc078b4b227e953e7611f0ca6fe6af (which isn't all that long
ago), or am I missing something?

$ git status
HEAD detached at origin/master
nothing to commit, working directory clean
$ git grep IFF_TX_SKB_SHARING
$

johannes

