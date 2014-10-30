Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:44986 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933696AbaJ3OwX (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Oct 2014 10:52:23 -0400
Message-ID: <1414680732.1823.8.camel@jlt4.sipsolutions.net> (sfid-20141030_155230_427985_19EDE28D)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
From: Johannes Berg <johannes@sipsolutions.net>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 30 Oct 2014 15:52:12 +0100
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com> (sfid-20141030_153828_295813_CF5BCA92)
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
	 <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com>
	 <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com>
	 (sfid-20141030_153828_295813_CF5BCA92)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-10-30 at 14:36 +0000, Grumbach, Emmanuel wrote:

> +GCC_VERSION=$(shell gcc --version | head -1 | awk '{print $4}')
> +ifeq ($(GCC_VERSION), 4.8.2)

Luis, I can't really figure out why you think the *compiler* version
matters? Maybe the linker version, but ...?

johannes

