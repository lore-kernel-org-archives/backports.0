Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64556 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbaDBCgW (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 1 Apr 2014 22:36:22 -0400
Received: by mail-lb0-f176.google.com with SMTP id 10so7496012lbg.7
        for <backports@vger.kernel.org>; Tue, 01 Apr 2014 19:36:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395390993-15263-1-git-send-email-johannes@sipsolutions.net>
References: <1395390993-15263-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 1 Apr 2014 19:36:00 -0700
Message-ID: <CAB=NE6VDZKOPpYSQ5wR3ZQk3bFBEqv2Y0ZzKaoKbyQ=nFe1N4A@mail.gmail.com> (sfid-20140402_043624_217125_6FC31C22)
Subject: Re: [PATCH v2] backports: fix compilation with CONFIG_OF
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Jouni Malinen <j@w1.fi>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Mar 21, 2014 at 1:36 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> There are two users of of_find_property_value_of_size() which is
> originally static in the kernel, but we need it exposed (but not
> exported) so that multiple backport files can use it; do that.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks! Queued it up.

  Luis
