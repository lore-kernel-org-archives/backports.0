Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40021 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbcELJ2w (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 May 2016 05:28:52 -0400
Message-ID: <1463045327.13313.17.camel@sipsolutions.net> (sfid-20160512_112855_036569_32E13A4E)
Subject: Re: Linux backports CII badge and run time testing
From: Johannes Berg <johannes@sipsolutions.net>
To: Fengguang Wu <fengguang.wu@intel.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Jouni Malinen <jkmalinen@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Huang Ying <ying.huang@intel.com>,
	Philip Li <philip.li@intel.com>
Date: Thu, 12 May 2016 11:28:47 +0200
In-Reply-To: <20160512000635.GA12984@wfg-t540p.sh.intel.com>
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
	 <CANe27jLBmahqRc6ryNxSTKAwo5qkD8NAW+iB8cVGYWOAavF1qA@mail.gmail.com>
	 <CAB=NE6V4jYusMZxKw27D+W1_zLSdzP-v9iATeFU45gPYs=VxNQ@mail.gmail.com>
	 <20160512000635.GA12984@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2016-05-12 at 08:06 +0800, Fengguang Wu wrote:

> FYI 0-day runs simple hwsim tests based on
> 
>         git://w1.fi/srv/git/hostap.git
> 
> The 0-day test scripts are
> 
>         https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/tests/hwsim
>         https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/pack/hwsim

All of them? Wow. Can we see the results of that somewhere?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
