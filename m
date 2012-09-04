Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57343 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752761Ab2IDKwm (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 4 Sep 2012 06:52:42 -0400
Received: by lagy9 with SMTP id y9so4058547lag.19
        for <backports@vger.kernel.org>; Tue, 04 Sep 2012 03:52:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGj=iG_FzEsiU-25ckfiC8sbzq1rq-mPnexgRBqki+Q0+d82ew@mail.gmail.com>
References: <CAGj=iG9meBuxqz=UsYwYW5pHbCXgsAp2eHi04ZK0LTLHHPu+=w@mail.gmail.com>
	<CAGj=iG-wdYJe4CZBCJ=VfPxUA1NiOQi_356dSYsNZQ4v6fxkeg@mail.gmail.com>
	<CAGj=iG_FzEsiU-25ckfiC8sbzq1rq-mPnexgRBqki+Q0+d82ew@mail.gmail.com>
Date: Tue, 4 Sep 2012 12:52:40 +0200
Message-ID: <CAGj=iG-wTJGOi+WFJ8fXyeVh=S5335zjdDniyTPfvmi=nXSKqA@mail.gmail.com>
Subject: Re: Compiling only one driver
From: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am sorry. I forgot to be more specific about my impressions: is it
enough to just comment all the drivers in the file "driver-select"
apart from the one I am using (ath9k) and edit the makefile that it
points to (ATH9K_MAKEFILE="drivers/net/wireless/ath/ath9k/Makefile")
with the cross-compiler that I am going to use?

Thanks a lot.
