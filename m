Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43907 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab3BCTTi convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 3 Feb 2013 14:19:38 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so2597147wgb.2
        for <backports@vger.kernel.org>; Sun, 03 Feb 2013 11:19:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <510EB634.3080704@hauke-m.de>
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
	<510EB634.3080704@hauke-m.de>
Date: Sun, 3 Feb 2013 21:19:36 +0200
Message-ID: <CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Add possibility to build every subsystem separately
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>
> Why are you removing the ifeq ($(BT),) here?

Well I didn't get what it does. (It seems to switch on/off bluetooth
but not in an intuitive way) Also it was always set to True without
user's intervention so I removed it to provoke a discussion about its
functionality :p

> I think it is better to add all (gpu and network) when nothing specific
> was given, this way the script does the same when the same parameters
> are given than it did before.

Well yes you are right but then we have to change the parameter logic
to support disabling subsystems, e.g.

admin-update.sh --disable-network.

--
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
