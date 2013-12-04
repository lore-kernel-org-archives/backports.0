Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51364 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3LDXM5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 4 Dec 2013 18:12:57 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so27512011iec.5
        for <backports@vger.kernel.org>; Wed, 04 Dec 2013 15:12:55 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Dec 2013 15:12:55 -0800
Message-ID: <CAEsx0Y_RwZSks_EqBYY7XxUgiRaX4qP-yrSK4Lx4Mbdi1iqNtQ@mail.gmail.com> (sfid-20131205_001258_905769_7958BBD6)
Subject: menuconfig
From: Daniel Schultze <kinglag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello Developers,

I'm trying to use backports for its updated Bluetooth drivers on
Kernel 2.6.31. When I make menu config in LTIB the line for Bluetooth
support does not appear, however when I make menuconfig for the host
the line for Bluetooth appears, I'm using the same source archive from
backports-3.13-rc2-1 and I also tried backports-3.11.8-1 with the same
result. What should I check to make the Bluetooth line appear?

-Dan
