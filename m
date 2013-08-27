Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:64514 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab3H0Vjd (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 17:39:33 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so4082090lab.31
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 14:39:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
References: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 27 Aug 2013 14:39:11 -0700
Message-ID: <CAB=NE6UbRv-29XvMLLmfsxsACMQDXbDM=KeTFcUW+dGPWDx1VQ@mail.gmail.com> (sfid-20130827_233950_363606_587F7449)
Subject: Re: [PATCH 1/4] backports: fix compilation for 2.6.25 for math64 header
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Aug 27, 2013 at 2:44 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> We need to ifdef correctly before assuming we can include that
> header.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Patch was was just Johannes' latest patch, I applied that on top of my
series but just nuked it from being sent.

  Luis
