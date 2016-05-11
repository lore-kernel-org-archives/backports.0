Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57123 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbcEKXPH (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 May 2016 19:15:07 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 74732201E4
	for <backports@vger.kernel.org>; Wed, 11 May 2016 23:15:05 +0000 (UTC)
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com [209.85.161.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 00D99201B9
	for <backports@vger.kernel.org>; Wed, 11 May 2016 23:15:02 +0000 (UTC)
Received: by mail-yw0-f182.google.com with SMTP id j74so57782003ywg.1
        for <backports@vger.kernel.org>; Wed, 11 May 2016 16:15:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANe27jLBmahqRc6ryNxSTKAwo5qkD8NAW+iB8cVGYWOAavF1qA@mail.gmail.com>
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
 <CANe27jLBmahqRc6ryNxSTKAwo5qkD8NAW+iB8cVGYWOAavF1qA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 11 May 2016 16:14:42 -0700
Message-ID: <CAB=NE6V4jYusMZxKw27D+W1_zLSdzP-v9iATeFU45gPYs=VxNQ@mail.gmail.com> (sfid-20160512_011511_811953_FD3C8954)
Subject: Re: Linux backports CII badge and run time testing
To: Jouni Malinen <jkmalinen@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 5, 2016 at 2:46 AM, Jouni Malinen <jkmalinen@gmail.com> wrote:
> On Thu, May 5, 2016 at 1:34 AM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>
>> As for run time testing, we know folks out there in the industry
>> already use backports and do their own run time tests against drivers,
>> and this may be automated, we however need something more, at the very
>> least a boot.
>
> All the automated wpa_supplicant/hostapd testing with mac80211_hwsim
> on my server use Backports: http://buildbot.w1.fi/hwsim/

Quite impressive work, thanks!

> The current model does not focus on testing Backports, so I'm only
> updating that manually every now and then while hostap.git updates are
> automated (that being the main focus for testing). That said, it would
> be trivial to update Backports to the latest snapshot whenever running
> the test. In fact, the same server is already generating snapshot
> builds of Backports from wireless-testing.git daily.

Interesting...

> This is all with a single base kernel version, though, so if you want
> more coverage in that front, you'd want to run the same setup against
> multiple kernels.

Indeed, this raises the question of "what to test" exactly, given
backports really is a subset of Linux. The automated tests you have
seem more in line for things perhaps we should get 0-day to consider
embracing so that if a regression is introduced linux-wireless
developers are nagged with the respective commit ID and tests cases
(if this is not done already). Upstream and 0-day seems like a much
more suitable place to test daily updates on the 802.11 front.

Backports-wise we should cover at least basic functionality, but
annotating that if an issue is present on backports with the latest
linux-next release it may also exist on upstream linux-next, and as
such not a backports issue but rather an upstream issue. Its this fine
line of overlap we need a way to somehow remove, and only test things
which ensure the backporting works for an array of kernels.

In lack of 0-day integration for wpa_supplicant / hostapd with
mac80211_hwsim (and leaving aside its debate over doing so or not),
intuitively I think its a fair assumption to make that linux-next
mac80211_hwisim should at the very least be able to load and perhaps
run a series of *basic functionality*. If this is agreeable, and
reducing the test cases is indeed easy and possible, I think a series
of basic tests are indeed called for as reasonable for backports to
integrate for testing as part of its own infrastructure specially
given 802.11 is a major stakeholder. In that sense, perhaps we can
cover basic testing for each subsystem, and for 802.11 then testing
mac80211_hwsim with basic functionality would be our litmus test.

Thoughts? If agreeable then perhap we just need something similar for
each subsystem we decide to take on.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
