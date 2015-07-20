Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35888 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbGTWiD (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 18:38:03 -0400
Received: by wicgb10 with SMTP id gb10so38971054wic.1
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 15:38:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 20 Jul 2015 15:37:42 -0700
Message-ID: <CAB=NE6VNEmU2QEHa=FWnDT_x4syawVqN_FaSLWEvAu3Pd5dnEg@mail.gmail.com> (sfid-20150721_003805_819535_EE570E4F)
Subject: Re: [PATCH v2 0/2] backports: respin on 0002-no_dmabuf SmPL and
 ckmake changes
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 20, 2015 at 3:30 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> This v2 is a respin with the ckmake format changes fixed. I'll merge
> this now as I had not heard feedback on the v1 spin and this is needed
> to move on with life.
>
> Luis R. Rodriguez (2):
>   patches: replace most of 0002-no_dmabuf with SmPL
>   ckmake: address directory max depth

Pushed.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
