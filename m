Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34816 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbFHS65 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 14:58:57 -0400
Received: by igbzc4 with SMTP id zc4so69195749igb.0
        for <backports@vger.kernel.org>; Mon, 08 Jun 2015 11:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555CA897.4010606@lwfinger.net>
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
 <1432110463.2174.2.camel@sipsolutions.net> <1432110664.5612.6.camel@intel.com>
 <1432110893.2174.3.camel@sipsolutions.net> <1432111194.8314.1.camel@intel.com>
 <555CA897.4010606@lwfinger.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Jun 2015 11:58:36 -0700
Message-ID: <CAB=NE6W9qF9YK8WyBDFCQewDiAV_V7-Jvo97kp1e5NfTfGyROQ@mail.gmail.com> (sfid-20150608_205900_596314_CD364EB5)
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 20, 2015 at 8:30 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> I am really pissed off about Ubuntu's backporting API changes so that
> testing LINUX_VERSION_CODE is no longer sufficient. In fact when someone
> complains the one of the out-of-kernel drivers that I maintain does not
> build with kernel X.Y, I check that version out in mainline, build the
> driver to make sure the problem is not mine, and then tell them to complain
> to their vendor. I no longer fix those problems. I think RHEL is also doing
> the same kind of thing - at least I did get one complaint about a build
> problem that seemed to be due to an API backport. Where do we stop?

Distros have been doing backporting for years, and their solutions
differ a bit, the Linux backports projects provides an outlet to
generalize a bit of this work through a systematic approach that aims
towards automation as much as possible. Some distributions have
already found value to this and embrace backports somehow, some others
are considering how to integrate it. For those distributions that have
already embraced backports and that also provide their own ABI they
resort to ABI solutions as described in this thread and patch. As an
example Red Hat already has integrated into backports support to
address ABI differences and they do that themselves, we welcome this.
Other distros should follow suit if they need this as well, and
obviously their solution should not interfere with the general
kernels.

On the other hand based on experience with these issues we have also
embraced proactive practices over time to try to avoid conflicts with
such kernel ABIs, one example was to embrace the #idef foo strategy
which checks to see if a kernel has defined a "foo" API already
instead of #if code with LINUX_VERSION_CODE stuff in which we know an
upstream kernel defined it, as is typically done. This is a strategy
*new* developers can embrace to help with this problem but it means
new code should use these #define strategies somehow when introducing
APIs.

For a while now I have been suggesting that over time we will likely
run into concrete items for automation for backporting or just general
backporting which could implicate how we should do development
upstream. This is an example of one of those best practices that could
be widely embraced to help make backporter's life easier. If we want
to take this a step further, which I want to, we'd add a grammatical
strategy to help with automation but I don't think we're there yet to
formalize that precisely just yet.

 Luis
