Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:53575 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3H0PtN (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 11:49:13 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so3671472lab.17
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 08:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net>
References: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 27 Aug 2013 08:48:51 -0700
Message-ID: <CAB=NE6VBhHkfFPd-kBKfscy2P=EVQ7jNevYQ5nVU2y_aFsCP-Q@mail.gmail.com> (sfid-20130827_174915_556578_C0A1EA1B)
Subject: Re: [RFC] remove support for kernel 2.6.24
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Aug 23, 2013 at 4:43 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> By requiring 2.6.25 we can get rid of quite a lot of backport work.
> 2.6.25 was released more than five years ago (April 2011) and wasn't
> a long-term kernel either, so there's little point in supporting it
> now.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I'm fine with this, please feel free to send as patch form unless you
want me to just accept it as is, I'd test compile it before
integration into the public tree.

 Luis
