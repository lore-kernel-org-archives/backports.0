Return-path: <backports-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41974 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab3EMFDH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 01:03:07 -0400
Date: Mon, 13 May 2013 06:03:05 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Subject: Re: [RFC] backports: add remove_proc_subtree() backport
Message-ID: <20130513050305.GT25399@ZenIV.linux.org.uk> (sfid-20130513_070309_857905_69197CE9)
References: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 09:31:38PM -0700, Luis R. Rodriguez wrote:

> This implementation uses recursion then if subdirs are found
> otherwise it treats it as a regular remove_proc_entry()

Ugh...  What for?  It's not as if traversing the damn thing had
been complicated:
	de = root = root of subtree to be killed
	unlink de
	while true
		/* de is already unlinked */
		if de has children
			child = first child of de
			unlink child
			de = child
		else
			/* de can be killed now */
			parent = parent of de
			kill de
			if de == root
				return
			de = parent
and that's it.  Why bother with recursion, chew stack space, etc.?
We do depth-first walk through the tree, unlinking the nodes from the
lists of children on the way in and freeing them on the way out.

The difference from your variant is that you use the stack to hold
pointers to ancestors of the current victim.  You get to the parent
of said victim by discarding a stack frame.  No need, since the
victim contained an explicit pointer to its parent...
