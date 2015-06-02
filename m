Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35230 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFBTF5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Jun 2015 15:05:57 -0400
Received: by wgme6 with SMTP id e6so147943775wgm.2
        for <backports@vger.kernel.org>; Tue, 02 Jun 2015 12:05:56 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
Date: Tue, 02 Jun 2015 21:05:54 +0200
Message-ID: <1524937.er13hZCs1L@leonov> (sfid-20150602_210600_710061_A12D7050)
In-Reply-To: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

On Thursday 28 of May 2015 19:54:57 Luis R. Rodriguez wrote:
> Me and Julia are working on a paper which evaluates use of Coccinelle
> on backports, a preliminary draft of such paper can be found on github
> [0]. We are making some tweaks to this, one of which is covering the
> uses of Linux backports [1] in the industry, for this we'd like to try
> to get feedback as to where and how folks are using backports. Please
> let me and Julia know -- or if the information is not sensitive please
> feel free to just reply to this thread and share with others. All
> feedback is greatly appreciated. If you are OK in having us list or
> generalize your usage please indicate so.

We use backports in 'BlueZ for Android' project [0]. Our reference tree [1] 
based on AOSP for Nexus devices is shipped with 3.4 kernel which is way too 
old for any Bluetooth Low Energy. Thanks to backports we can easily update BT 
subsystem while interesting feature enters bluetooth-next (via linux-next).
If there were no backports our project would be much harder if not impossible 
to achieve!

Since we use Android kernel we do have to fix some build issues from time to 
time but in overall this is quite easy and really straight forward.

[0] https://01.org/bluez-android
[1] https://code.google.com/p/aosp-bluez/

-- 
BR
Szymon Janc
