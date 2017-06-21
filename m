Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50802 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdFUVSu (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 21 Jun 2017 17:18:50 -0400
Message-ID: <1498079928.9688.2.camel@sipsolutions.net> (sfid-20170621_231857_105152_81584ABB)
Subject: Re: [PATCH V2] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 21 Jun 2017 23:18:48 +0200
In-Reply-To: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170621_225830_268542_FFBDC610)
References: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170621_225830_268542_FFBDC610)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Perhaps that can be fixed as such:

> +@r2 depends on r1@
> +identifier r1.D, r1.C;
> +fresh identifier E = "__" ## D;

attribute __maybe_unused;

> +@@
> +
> ++#if LINUX_VERSION_IS_LESS(4,13,0)
> ++static void E(struct net_device *ndev)

__maybe_unused

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
