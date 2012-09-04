Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48573 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752309Ab2IDKdl convert rfc822-to-8bit
	(ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 4 Sep 2012 06:33:41 -0400
Received: by lagy9 with SMTP id y9so4049054lag.19
        for <backports@vger.kernel.org>; Tue, 04 Sep 2012 03:33:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGj=iG-wdYJe4CZBCJ=VfPxUA1NiOQi_356dSYsNZQ4v6fxkeg@mail.gmail.com>
References: <CAGj=iG9meBuxqz=UsYwYW5pHbCXgsAp2eHi04ZK0LTLHHPu+=w@mail.gmail.com>
	<CAGj=iG-wdYJe4CZBCJ=VfPxUA1NiOQi_356dSYsNZQ4v6fxkeg@mail.gmail.com>
Date: Tue, 4 Sep 2012 12:33:39 +0200
Message-ID: <CAGj=iG_FzEsiU-25ckfiC8sbzq1rq-mPnexgRBqki+Q0+d82ew@mail.gmail.com>
Subject: Compiling only one driver
From: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello guys,

First of all I am going to introduce myself. I am Felipe López and I
am trying to cross-compile the ath9k_htc driver for a ar9271 chipset.
I bought a usb stick (specifically, the TP-LINK TL-WN722N) to build a
small web server using the following board: Eddy v2.5

I have it working in a PC (Ubuntu 11.04). Now I want to do the same
for a embedded Linux (kernel 2.6.21) wich is the one that the Eddy's
board comes with. The problem is that I can not figure out how to edit
the makefile to cross-compile the driver for the embedded linux. I
have another wifi dongle for that board but it can not be put in AP
mode, so I tried with this one but I didn't succeed yet. Can anybody
help me? I think that I only need to know how to isolate the ath9k
driver from the others and cross-compile only this one.

Thanks in advance.
