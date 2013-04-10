Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:40469 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935970Ab3DJUM2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 16:12:28 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so938656wgh.27
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 13:12:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365601666.4235.18.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-17-git-send-email-mcgrof@do-not-panic.com> <1365601666.4235.18.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 13:12:05 -0700
Message-ID: <CAB=NE6XjJJdbyDV5Za9112grmDSOmxKXs+5CKEKf2z1WA4e8mQ@mail.gmail.com> (sfid-20130410_221232_071242_BC270019)
Subject: Re: [PATCH 16/18] backports: add udev rules if required for
 backported firmware_class
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:47 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Oh, I wonder if there's a way to know this isn't needed on newer
> kernels? But I guess it doesn't really hurt anyway.

Its where we left off on compat-drivers so I welcome evolutions :)

  Luis
