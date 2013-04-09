Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50520 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760614Ab3DIPpA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Apr 2013 11:45:00 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so6936728lbd.2
        for <backports@vger.kernel.org>; Tue, 09 Apr 2013 08:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365498693-21795-1-git-send-email-johannes@sipsolutions.net>
References: <1365498693-21795-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Apr 2013 08:44:38 -0700
Message-ID: <CAB=NE6XRvCJPpea8teOjGqCGhX7Kz5zQybhcLc+ZvdEmY+iM2A@mail.gmail.com> (sfid-20130409_174503_481186_80610AEF)
Subject: Re: [PATCH] backports: add backport version to all modules
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 9, 2013 at 2:11 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> We print out the backports version at runtime, but it
> can also be useful to be able to determine it from the
> installed modules.
>
> As we already override module_init() to make all our
> backported modules depend on compat.ko (in order to do
> exactly this -- print out the version at runtime) also
> add some MODULE_VERSION directives to it.
>
> This results in, for example for mac80211, this:
>
> $ /sbin/modinfo .../net/mac80211/mac80211.ko
> filename:       .../net/mac80211/mac80211.ko
> license:        GPL
> description:    IEEE 802.11 subsystem
> version:        backported from: Linux (next-20130405-0-g7df052b)
> version:        backports: 6e0475b
> srcversion:     6C298E6033E34EA8E223D7B
> depends:        cfg80211,compat
> vermagic:       3.8.0 SMP mod_unload modversions
> parm:           max_nullfunc_tries:Maximum nullfunc tx tries before disconnecting (reason 4). (int)
> parm:           max_probe_tries:Maximum probe tries before disconnecting (reason 4). (int)
> parm:           probe_wait_ms:Maximum time(ms) to wait for probe response before disconnecting (reason 4). (int)
> parm:           ieee80211_default_rc_algo:Default rate control algorithm for mac80211 to use (charp)
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Fuck-yeah: Luis R. Rodriguez <mcgrof@do-not-panic.com>

  Luis
