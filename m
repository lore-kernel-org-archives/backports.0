Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38951 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaEBBlT (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:41:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so2577677pde.26
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:41:19 -0700 (PDT)
Date: Thu, 1 May 2014 18:41:13 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Avery Pennarun <apenwarr@gmail.com>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH] Makefile: add savedefconfig target.
Message-ID: <20140502014113.GI957@garbanzo.do-not-panic.com> (sfid-20140502_034121_149897_A38B628A)
References: <1398821346-17344-1-git-send-email-apenwarr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398821346-17344-1-git-send-email-apenwarr@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 29, 2014 at 09:29:06PM -0400, Avery Pennarun wrote:
> This writes a file called 'defconfig' which contains only the deltas from
> the default configuration.  It's suitable for use as an input defconfig file
> for later builds.
> 
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

Neat, thanks, applieds!

  Luis
