Return-path: <backports-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41999 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab3EMFkn (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 01:40:43 -0400
Date: Mon, 13 May 2013 06:40:42 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [RFC] backports: add remove_proc_subtree() backport
Message-ID: <20130513054042.GU25399@ZenIV.linux.org.uk> (sfid-20130513_074046_553591_588EB37F)
References: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com>
 <20130513050305.GT25399@ZenIV.linux.org.uk>
 <CAB=NE6UeupVx+DPuwg1hh1Y09Bb1vF08uObvpyhBS1wwMFUaZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6UeupVx+DPuwg1hh1Y09Bb1vF08uObvpyhBS1wwMFUaZw@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 10:21:02PM -0700, Luis R. Rodriguez wrote:

> > The difference from your variant is that you use the stack to hold
> > pointers to ancestors of the current victim.  You get to the parent
> > of said victim by discarding a stack frame.  No need, since the
> > victim contained an explicit pointer to its parent...
> 
> Except I thought NULL was passed?

AFAICS, your variant removes _everything_ in the parent.  IOW, instead
of
	rm -rf $ROOT/$RELATIVE_PATH
you do
	test -n $ROOT && rm -rf $ROOT/*
	rm $ROOT/$RELATIVE_PATH
which is not the same thing...
