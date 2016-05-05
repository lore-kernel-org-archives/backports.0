Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34867 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401AbcEEJqU (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 5 May 2016 05:46:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id w198so12830187oiw.2
        for <backports@vger.kernel.org>; Thu, 05 May 2016 02:46:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
Date: Thu, 5 May 2016 12:46:19 +0300
Message-ID: <CANe27jLBmahqRc6ryNxSTKAwo5qkD8NAW+iB8cVGYWOAavF1qA@mail.gmail.com> (sfid-20160505_114624_380034_79C2F959)
Subject: Re: Linux backports CII badge and run time testing
From: Jouni Malinen <jkmalinen@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 5, 2016 at 1:34 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:

> As for run time testing, we know folks out there in the industry
> already use backports and do their own run time tests against drivers,
> and this may be automated, we however need something more, at the very
> least a boot.

All the automated wpa_supplicant/hostapd testing with mac80211_hwsim
on my server use Backports: http://buildbot.w1.fi/hwsim/

The current model does not focus on testing Backports, so I'm only
updating that manually every now and then while hostap.git updates are
automated (that being the main focus for testing). That said, it would
be trivial to update Backports to the latest snapshot whenever running
the test. In fact, the same server is already generating snapshot
builds of Backports from wireless-testing.git daily.

This is all with a single base kernel version, though, so if you want
more coverage in that front, you'd want to run the same setup against
multiple kernels.

- Jouni
--
To unsubscribe from this list: send the line "unsubscribe backports" in
