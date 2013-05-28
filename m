Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:38520 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab3E1UCd (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 16:02:33 -0400
Received: by mail-we0-f182.google.com with SMTP id q57so5429658wes.41
        for <backports@vger.kernel.org>; Tue, 28 May 2013 13:02:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
 <1369224306.8207.7.camel@jlt4.sipsolutions.net> <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
 <1369322755.12002.21.camel@jlt4.sipsolutions.net> <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 May 2013 13:02:12 -0700
Message-ID: <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com> (sfid-20130528_220235_223278_ADD35DDC)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 23, 2013 at 2:02 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> I see what you're saying now and I actually did consider it, the
> reason I didn't use --git-revision is speed. Git reset --hard tag, and
> then copying the code directly is a lot faster. The race issues you
> point out though are worth reconsidering this though.

I've given this some thought and I find that the theoretical race
conditions also applies even if you use --git-revision on the output
path. A true paranoid release model would then have a target output
directory only the parent process and children could modify / update
but given it seems we have considerations for non ext[34] filesystems
(recent kconfig patch) its unclear we could resolve this for the truly
paranoid. The speed considerations I raised then (10 seconds as of
next-20130523 with python-git installed) could be discarded in favor
of consistency of just using --git-revision for a release model
provided we also address the RELMOD_UPDATE and RELMOD_TYPE
specification for both daily and stable releases, defined on the
upload_release() documentation. Right now we infer RELMOD_UPDATE based
on the output directory but inferring RELMOD_TYPE from the same target
output directory would be sloppy IMO so tackling these two with
--git-revision would need to be addressed.

  Luis
