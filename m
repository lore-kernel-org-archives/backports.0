Return-path: <backports-owner@vger.kernel.org>
Received: from s16502780.onlinehome-server.info ([87.106.93.118]:53781 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751843Ab3GSNRb (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 09:17:31 -0400
Date: Fri, 19 Jul 2013 13:31:46 +0100
From: Chris Wilson <chris@chris-wilson.co.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, jani.nikula@intel.com,
	annndddrr@gmail.com, cpanceac@gmail.com, daniel.vetter@ffwll.ch,
	greg@kroah.com
Subject: Re: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
Message-ID: <20130719123146.GC9288@cantiga.alporthouse.com> (sfid-20130719_151733_930143_3A3136C2)
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
 <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jul 19, 2013 at 05:00:06AM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> struct dmi_strmatch was modified on v3.11 with a
> exact_match member. The DMI_EXACT_MATCH() macro was
> added as a mod version of DMI_MATCH() to account for
> dmi strings that look closely like each other. An
> example is D510MO Vs D510MOV.
> 
> Since exact_match is is not available on older kernels
> we can't use it and must revert to the old DMI_MATCH().
> Addressing the desired behaviour will require a separate
> change to deal with addressing the difference
> in the behaviour.

If you choose not to backport DMI_EXACT_MATCH, then don't backport the
two fixes that depend upon it.

Is there a blocker for not backporting the DMI_EXACT_MATCH feature?
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
