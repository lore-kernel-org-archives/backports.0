Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34869 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab3HARBB (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 13:01:01 -0400
Received: by mail-la0-f52.google.com with SMTP id fq13so1612467lab.39
        for <backports@vger.kernel.org>; Thu, 01 Aug 2013 10:00:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51FA85D0.1040909@fh-kl.de>
References: <cover.1375372668.git.patrick.ziegler@fh-kl.de> <51FA85D0.1040909@fh-kl.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 1 Aug 2013 10:00:36 -0700
Message-ID: <CAB=NE6V8KXUCWpP3-GjdO4tbqYOw9FERdTiq3SvsNNVYCrrsyQ@mail.gmail.com> (sfid-20130801_190104_183214_56F79F7B)
Subject: Re: [RFC v3 2/9] backports: add eth_prepare_mac_addr_change() and eth_commit_mac_addr_change()
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 1, 2013 at 8:59 AM, Patrick Ziegler
<patrick.ziegler@fh-kl.de> wrote:
> +EXPORT_SYMBOL(eth_prepare_mac_addr_change);

Just one thing:

https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking#Backporting_preference_for_EXPORT_SYMBOL_GPL.28.29_and_proprietary_drivers

If you want I can mend on my end, let me know.

  Luis
