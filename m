Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:33458 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3EMFVY (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 01:21:24 -0400
Received: by mail-we0-f180.google.com with SMTP id n5so5715206wev.39
        for <backports@vger.kernel.org>; Sun, 12 May 2013 22:21:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130513050305.GT25399@ZenIV.linux.org.uk>
References: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com> <20130513050305.GT25399@ZenIV.linux.org.uk>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 22:21:02 -0700
Message-ID: <CAB=NE6UeupVx+DPuwg1hh1Y09Bb1vF08uObvpyhBS1wwMFUaZw@mail.gmail.com> (sfid-20130513_072126_229149_ABE2DC4D)
Subject: Re: [RFC] backports: add remove_proc_subtree() backport
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 10:03 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, May 12, 2013 at 09:31:38PM -0700, Luis R. Rodriguez wrote:
>
>> This implementation uses recursion then if subdirs are found
>> otherwise it treats it as a regular remove_proc_entry()
>
> Ugh...  What for?

I could not figure out a way to traverse the tree safely without being
able to use the proc_subdir_lock spinlock. Given that the way we
backport is through an external module I had to look at what ways this
could be done safely.

> It's not as if traversing the damn thing had
> been complicated:
>         de = root = root of subtree to be killed
>         unlink de
>         while true
>                 /* de is already unlinked */
>                 if de has children
>                         child = first child of de
>                         unlink child
>                         de = child
>                 else
>                         /* de can be killed now */
>                         parent = parent of de
>                         kill de
>                         if de == root
>                                 return
>                         de = parent
> and that's it.  Why bother with recursion, chew stack space, etc.?

I would pick up the same implementation if we could but not having
access to the locks and also in the case of NULL being passed as the
parent, which some drivers do pass I couldn't see how to easily get
access to &proc_root. So this is what I came up with and so I wanted
to check if perhaps I missed something.

> We do depth-first walk through the tree, unlinking the nodes from the
> lists of children on the way in and freeing them on the way out.

OK thanks for the clarification.

> The difference from your variant is that you use the stack to hold
> pointers to ancestors of the current victim.  You get to the parent
> of said victim by discarding a stack frame.  No need, since the
> victim contained an explicit pointer to its parent...

Except I thought NULL was passed?

  Luis
