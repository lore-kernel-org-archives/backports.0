Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:64701 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbaDHAiG (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 20:38:06 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so175748lab.32
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 17:38:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5342AED7.5080505@kpanic.de>
References: <5342AED7.5080505@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 7 Apr 2014 17:37:44 -0700
Message-ID: <CAB=NE6WdU4fLKz9eMbVFqiD-r4YE2Hz8fo2cH9A18R7ap=hvDA@mail.gmail.com> (sfid-20140408_023809_287491_00F187FA)
Subject: Re: ckmake build issue with undefined symbol mcount
To: Stefan Assmann <sassmann@kpanic.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 7, 2014 at 6:57 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> next-20140221

Did you git reset --hard backports-20140221 ? The respective dated tag
for backports must be used for a specific dated tag for linux-next.
Likewise for the stable releases.

  Luis
