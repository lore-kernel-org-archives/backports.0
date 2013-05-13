Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:45332 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3EMGOa (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 02:14:30 -0400
Received: by mail-we0-f177.google.com with SMTP id q58so5904837wes.22
        for <backports@vger.kernel.org>; Sun, 12 May 2013 23:14:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130513054042.GU25399@ZenIV.linux.org.uk>
References: <1368419498-15809-1-git-send-email-mcgrof@do-not-panic.com>
 <20130513050305.GT25399@ZenIV.linux.org.uk> <CAB=NE6UeupVx+DPuwg1hh1Y09Bb1vF08uObvpyhBS1wwMFUaZw@mail.gmail.com>
 <20130513054042.GU25399@ZenIV.linux.org.uk>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 23:14:09 -0700
Message-ID: <CAB=NE6X6Y35i7opGwh4rD++r-uGsLkVcafu4o17D8141BNU41Q@mail.gmail.com> (sfid-20130513_081433_115839_EEAABF8E)
Subject: Re: [RFC] backports: add remove_proc_subtree() backport
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 10:40 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, May 12, 2013 at 10:21:02PM -0700, Luis R. Rodriguez wrote:
>
>> > The difference from your variant is that you use the stack to hold
>> > pointers to ancestors of the current victim.  You get to the parent
>> > of said victim by discarding a stack frame.  No need, since the
>> > victim contained an explicit pointer to its parent...
>>
>> Except I thought NULL was passed?
>
> AFAICS, your variant removes _everything_ in the parent.  IOW, instead
> of
>         rm -rf $ROOT/$RELATIVE_PATH
> you do
>         test -n $ROOT && rm -rf $ROOT/*
>         rm $ROOT/$RELATIVE_PATH
> which is not the same thing...

Crap, yes, I see now thanks. I can't see how we can safely traverse
the tree to find the respective struct proc_dir_entry for the passed
name as a modular solution. That is, in order to rm -rf
$ROOT/$RELATIVE_PATH I first need the $ROOT/$RELATIVE_PATH struct
proc_dir_entry.

Any recommendations?

  Luis
