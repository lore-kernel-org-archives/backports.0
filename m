Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:45516 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab3LHOyj (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 8 Dec 2013 09:54:39 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so2409082wes.24
        for <backports@vger.kernel.org>; Sun, 08 Dec 2013 06:54:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A48629.6050905@hauke-m.de>
References: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
 <1386354570-23940-2-git-send-email-mcgrof@do-not-panic.com> <52A48629.6050905@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 8 Dec 2013 15:54:17 +0100
Message-ID: <CAB=NE6XTAW88aUVuF71B1p1H+M2MqVXepf45z9a47pwWbbS3gQ@mail.gmail.com> (sfid-20131208_155441_389480_A5059D70)
Subject: Re: [PATCH 1/3] backports: backport ktime_to_ms()
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Dec 8, 2013 at 3:46 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
>
> Add this line here, otherwise we get problems with RHEL.
> #define ktime_to_ms LINUX_BACKPORT(ktime_to_ms)

Doh, thanks, I've amended it.

  Luis
