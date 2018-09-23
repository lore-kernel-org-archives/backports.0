Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50860 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIXCPy (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:15:54 -0400
Message-ID: <1537733820.1707.10.camel@sipsolutions.net> (sfid-20180923_221712_660554_A3E53FDE)
Subject: Re: [PATCH 06/10] dependencies: make hostap and atmel depend on
 kernel >= 4.18
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:17:00 +0200
In-Reply-To: <20180923174535.16198-7-hauke@hauke-m.de> (sfid-20180923_194552_062144_6F12F664)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-7-hauke@hauke-m.de>
         (sfid-20180923_194552_062144_6F12F664)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> The hostap and atmel wireless driver now make use of the
> proc_create_single_data() function which can not easily be backported.
> As these drivers are not used too often just deactivate them on older
> kernel versions for now.

It should be pretty easy to backport based on proc_create_data(), which
has been around since 2.6.26?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
