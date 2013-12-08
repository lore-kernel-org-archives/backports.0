Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:50257 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3LHNfJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 8 Dec 2013 08:35:09 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so2440962wes.16
        for <backports@vger.kernel.org>; Sun, 08 Dec 2013 05:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A3A9B1.1080903@hauke-m.de>
References: <1386332707-9736-1-git-send-email-mcgrof@do-not-panic.com> <52A3A9B1.1080903@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 8 Dec 2013 14:34:47 +0100
Message-ID: <CAB=NE6UVnA5id40Hn3OfU4WoZJKhs4WKHDJc4byifxvFAEaepQ@mail.gmail.com> (sfid-20131208_143511_683620_82525F79)
Subject: Re: [PATCH v2] backports: add Python based get-backport-kernels
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Dec 8, 2013 at 12:05 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> sparse: not found

Doh, I made a huge typo and used C= instead of -C :) I'll submit a v3 next.

  Luis
