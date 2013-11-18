Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55321 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3KRX3H (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 18 Nov 2013 18:29:07 -0500
Received: by mail-qc0-f172.google.com with SMTP id l13so1170211qcy.31
        for <backports@vger.kernel.org>; Mon, 18 Nov 2013 15:29:06 -0800 (PST)
MIME-Version: 1.0
From: Jason Mobarak <jam@cozybit.com>
Date: Mon, 18 Nov 2013 15:28:46 -0800
Message-ID: <CANkDkvwBGyonC3JPvEh59bvfYxEix0N_21=5avX8RiCvyLpiOA@mail.gmail.com> (sfid-20131119_002909_500477_424F846A)
Subject: How to detect when module dependencies have changed?
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello--

I recently ran into an issue where the module dependencies changed
between the versions of backports that I was using and I had a hard
time determining what was going wrong with compiling the driver
against backports.

Basically the situation was this:
  - Worked on a driver using a 2013.08 development snapshot of kernel backports
  - I wanted to compile the driver against the latest backports (based
on next-20131113)
  - Discovered that the module was not being compiled, because the
CPTCFG_MAC80211 flag could not be enabled

The problem, I think, was that CRYPTO_CCM was added as a dependency of
of MAC80211 in the meantime.  I discovered this by using menuconfig to
figure out what config flags where causing MAC80211 to be disabled...

At first, to address this, I tried adding "crypto/" and
"drivers/crypto/" to "copy-list" and regenerating (which also
requiring some sed manipulation of the CONFIG_ flags)...

However, the more "correct" solution (which didn't require any changes
to backports) was to just enable CYPTO_CCM as a module in the kernel
backports was being compiled against.

So... my question is, is this a bug?  And/or is there a better way to
detect this situation in the future?

Thanks,
-Jason M
