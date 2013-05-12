Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44354 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3ELUWU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 12 May 2013 16:22:20 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so5874419wgh.24
        for <backports@vger.kernel.org>; Sun, 12 May 2013 13:22:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
 <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com> <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 13:21:59 -0700
Message-ID: <CAB=NE6Xk8M+Azx6QcBLfv4Du9Ax84DhFruSvxTTki=Dun1FMrg@mail.gmail.com> (sfid-20130512_222224_305345_E8290103)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 12:33 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
>
> http://drvbp1.linux-foundation.org/~mcgrof/backport-tmp/backports-20130426.tar.bz2

Realizing that you might want to see what this looked like prior to
your changes being merged into linux-next here is a tarball for that,
its based on next-20130415 and the backports git tree reset to
43c24dc310979c70d04269a5138eb1b5e77ac3d0.

http://drvbp1.linux-foundation.org/~mcgrof/backport-tmp/backports-20130415.tar.bz2

  Luis
