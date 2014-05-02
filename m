Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:55619 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaEBIpg (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 2 May 2014 04:45:36 -0400
Received: by mail-la0-f46.google.com with SMTP id pv20so2876040lab.33
        for <backports@vger.kernel.org>; Fri, 02 May 2014 01:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFjWW+ZzSvWzAWOC3dzDPujszXYs-pHkSr7wNiLJwwc3a-+-wQ@mail.gmail.com>
References: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com>
 <20140502013948.GH957@garbanzo.do-not-panic.com> <CAFjWW+ZzSvWzAWOC3dzDPujszXYs-pHkSr7wNiLJwwc3a-+-wQ@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 2 May 2014 01:45:14 -0700
Message-ID: <CAB=NE6U6Cxt2cToUJACh3emLDFSKb-Fq864c_kEH3ZBe8mJ0PA@mail.gmail.com> (sfid-20140502_104539_389789_AEA15C54)
Subject: Re: 3.14-1 Compile Problem for 2.6.39.4 Kernel
To: Aaron Hamilton <aaron@logicdatasystems.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, May 2, 2014 at 1:36 AM, Aaron Hamilton
<aaron@logicdatasystems.net> wrote:
> If I recall correctly, I was able to get this to compile by enabling
> CONFIG_CRYPTO_CCM in my kernel. Without it, it won't compile.

Yeah that would do it:

mcgrof@drvbp1 ~/ksrc-backports $ grep CRYPTO_CCM
lib/modules/2.6.39-02063904-generic/build/.config
CONFIG_CRYPTO_CCM=m

Unfortunately right now we don't compile tests against random configs
but as you can imagine doing so would take quite a bit of time. Even
so, we need a way to be able to nudge the config a bit to compile
everything we do expect to ship without compromising the config
enough. That might be tricky, best I can say for now is that we do
need a bit more review / help with alternative base configs.

  Luis
