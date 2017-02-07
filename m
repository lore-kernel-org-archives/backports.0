Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33370 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755509AbdBGVKF (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 16:10:05 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.88)
        (envelope-from <johannes@sipsolutions.net>)
        id 1cbCzy-0003xu-Dl
        for backports@vger.kernel.org; Tue, 07 Feb 2017 22:08:26 +0100
Message-ID: <1486501705.18071.1.camel@sipsolutions.net> (sfid-20170207_221034_779051_861CAC3E)
Subject: backports update
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 07 Feb 2017 22:08:25 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

After two days of work, I've pushed out a new backports tree.

Since there's a limit to the # of hours in a day, I've dropped a number
of things:
 * Ethernet
 * Media
 * Bluetooth
 * 6lowpan
 * made various other things depend on (too) high kernel versions

None of these things are unfixable - if anyone has a specific driver
they need patches are very welcome.

Currently, the master branch of the backports repository is now
intended to work with wireless-testing tag wt-2017-02-06, plus the
following patch: https://patchwork.kernel.org/patch/9560281/

ckmake isn't entirely happy - Ubuntu kernel versions 3.0-3.3 are
internally inconsistent and get errors in their own code and 3.7-4.4
are failing to link against 'mcount' which is again some ftrace problem
that I'm not willing to solve right now.

I assume with the correct kernel configuration these problems would go
away, and I think we should stop compiling against Ubuntu kernels that
nobody uses any more and instead focus on defconfigs that are actually
in use, perhaps taking some from the distros. But that's another story.

Please go and test this against your drivers/kernels/test beds.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
