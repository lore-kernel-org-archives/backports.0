MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Fri, 8 Mar 2013 23:29:34 -0800
Message-ID: <CAB=NE6VgjMOWJ_POwc4mKRuApafSxzbO1eWyUSdOQ0F5e_JYJA@mail.gmail.com>
Subject: compat-drivers-3.9-rc1-3 released
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

A -3 release goes out based on v3.9-rc1. In this revision update we
get now pending-stable patches fixed so that means we get an -s
release. Also on behalf of a report on this list I've added ar5523 to
driver-select as an option.

There are three releases:

https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.9-rc1/compat-drivers-3.9-rc1-3.tar.bz2
https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.9-rc1/compat-drivers-3.9-rc1-3-s.tar.bz2
https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.9-rc1/compat-drivers-3.9-rc1-3-su.tar.bz2

If unclear on the definition of the extra tags on the release please see:

https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers/additional-patches

The -s releases have these pending-stable networking patches sucked
out from linux-next and merged in. These would typically go into -rc2
but the model we have allows us to get them faster.

0001-iwlwifi-always-copy-first-16-bytes-of-commands.patch
0002-mac80211-Fix-crash-due-to-un-canceled-work-items.patch
0003-ath9k-fix-RSSI-dummy-marker-value.patch
0004-ath9k_htc-fix-signal-strength-handling-issues.patch
0005-ath9k_hw-improve-reset-reliability-after-errors.patch
0006-mwifiex-correct-sleep-delay-counter.patch
0007-rt2x00-error-in-configurations-with-mesh-support-dis.patch
0008-libertas-fix-crash-for-SD8688.patch
0009-rt2x00-rt2x00pci_regbusy_read-only-print-register-ac.patch

In this case there were no pending-stable patches for the DRM
subsystem. Please help test and report any issues you see. If anyone
has any type of patch they would like to see merged in that is *not*
marked as stable and if you think it won't get accepted as a stable
patch but you need it for your customers / mom / whoever, I'll take it
in, just be sure to add the patch to the respective category as
described in the wiki. The model is designed to let silicon vendors
address "customer" releases without breaking the upstream model, by
prioritizing the upstream process and categorizing patches in their
respective place, but also documenting them. In the end, for example,
this is designed to for example steer people away from annotating
patches under crap/.

  Luis
