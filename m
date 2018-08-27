Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44792 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1BuR (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 27 Aug 2018 21:50:17 -0400
Received: by mail-pf1-f169.google.com with SMTP id k21-v6so194072pff.11
        for <backports@vger.kernel.org>; Mon, 27 Aug 2018 15:01:46 -0700 (PDT)
Received: from Marlon-PC.hitronhub.home (S0106a84e3f53ec33.gv.shawcable.net. [184.66.238.184])
        by smtp.gmail.com with ESMTPSA id g5-v6sm250459pgn.73.2018.08.27.15.01.45
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 15:01:45 -0700 (PDT)
Message-ID: <1535407305.25991.36.camel@gmail.com> (sfid-20180828_000148_719689_13E49E95)
Subject: Backports not building configured drivers
From: Marlon Smith <marlon.smith10@gmail.com>
To: backports@vger.kernel.org
Date: Mon, 27 Aug 2018 15:01:45 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi everyone,

I'm using backports 4.14 to build for a custom kernel 3.14.  That
kernel includes the RT2800 wifi driver, and if I configure backports
with menuconfig to build a newer version of that driver it works
perfectly.  However, if I configure backports to build the RTL8821
driver, which my kernel otherwise does not include, the driver never
gets built and backports shows it as not selected the next time I run
menuconfig.

Is this expected behaviour?  Is there something I can do to force this
driver to build?

Thanks!

Marlon
--
To unsubscribe from this list: send the line "unsubscribe backports" in
