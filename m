Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61182 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbaDBCgz (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 1 Apr 2014 22:36:55 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so7780465lbd.29
        for <backports@vger.kernel.org>; Tue, 01 Apr 2014 19:36:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1393846461-21087-1-git-send-email-emmanuel.grumbach@intel.com>
References: <1393846461-21087-1-git-send-email-emmanuel.grumbach@intel.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 1 Apr 2014 19:36:34 -0700
Message-ID: <CAB=NE6VJ8csRbgEMTk3MUoPA38YdSaYFBAt5vkxZyehgEA7b3A@mail.gmail.com> (sfid-20140402_043657_772250_9BB85A7B)
Subject: Re: [PATCH] backports: ifdef some pci functions
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Eliad Peller <eliad@wizery.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Mar 3, 2014 at 3:34 AM, Emmanuel Grumbach
<emmanuel.grumbach@intel.com> wrote:
> From: Eliad Peller <eliad@wizery.com>
>
> struct msix_entry entry is defined only when CONFIG_PCI
> is defined, resulting in warnings like:
>
> backport-include/linux/pci.h:256:16: warning: 'struct msix_entry' declared inside parameter list [enabled by default]
> backport-include/linux/pci.h:256:16: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
>
> wrap (also the mock function) with appropriate ifdef CONFIG_PCI.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


Thanks! Queued it up!

  Luis
