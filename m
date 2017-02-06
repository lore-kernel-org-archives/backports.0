Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35900 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbdBFWpS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 17:45:18 -0500
Received: by mail-qt0-f174.google.com with SMTP id k15so119384187qtg.3
        for <backports@vger.kernel.org>; Mon, 06 Feb 2017 14:45:13 -0800 (PST)
Subject: Re: deprecating more kernel versions
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1486399064.5430.7.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <04ef169d-49b1-98e0-1db6-7c4e7e9b5c9f@broadcom.com> (sfid-20170206_234532_527890_82D4F704)
Date: Mon, 6 Feb 2017 23:45:08 +0100
MIME-Version: 1.0
In-Reply-To: <1486399064.5430.7.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 6-2-2017 17:37, Johannes Berg wrote:
> What kernel versions do you still need?
> 
> For example, 3.0 is getting really quite old, the oldest long-term
> stable is 3.2.x now.

We currently backport internal tree and wireless-testing nightly to 3.10
and 3.11 kernels.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
