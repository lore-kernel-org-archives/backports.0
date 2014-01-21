Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62111 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaAUJ4Q (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 21 Jan 2014 04:56:16 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so4423089pdj.12
        for <backports@vger.kernel.org>; Tue, 21 Jan 2014 01:56:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1390215684.4335.17.camel@jlt4.sipsolutions.net>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com>
 <1367933208.8328.11.camel@jlt4.sipsolutions.net> <CAPkN8xJjvBFQJHaEu_yUsHaeDybws02NcfegdyXq_+RN-XssOQ@mail.gmail.com>
 <1390215684.4335.17.camel@jlt4.sipsolutions.net>
From: anatoly techtonik <techtonik@gmail.com>
Date: Tue, 21 Jan 2014 12:55:52 +0300
Message-ID: <CAPkN8xLXbxbus9itoxBm97aF_EwbwN1YBk=E1R9xBvX31xUSvQ@mail.gmail.com> (sfid-20140121_105624_056305_A5EF111F)
Subject: Re: [PATCH 1/3] backports: update patch Python library
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jan 20, 2014 at 2:01 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2014-01-17 at 01:01 +0300, anatoly techtonik wrote:
>
>> Sorry for a long delay. I finally lost my job, so now I can have some continuous
>> time piece to concentrate on python-patch.
>
> Oops, sorry to hear that. You make it sound almost positive though.

Yes. It is too hard to cope with pressure in software development even though
I had rather relaxing terms in the industry. Must be a psychological problem -
something around OCD/ADHD, but that doesn't matter.

>> > We assume that all patches need one level stripped, but if a patch is a
>> > git patch (as indicated by having the "diff" and/or (?) "index" lines),
>> > then the patch library will already strip a level. That basically
>> > assumes that users use "-p0" on 'plain' patches, which isn't the case,
>> > we always use -p1.
>> >
>> > IOW, this will break dropping git patches (e.g. git
>> > diff/show/format-patch) into the patches directory.
>>
>> patch.py is smart enough to strip only a/ and b/ prefixes, and do this
>> automatically when it is needed.
>
> Well, yes, but it doesn't auto-detect other prefixes. So if I diff
> something manually, then the prefixes aren't removed.

There are no other prefixes. Everything else are real directories that exist
when you create the patch. Isn't it?

> As a result, I
> must generate the patch using git if I want it to work right, or must go
> against the -p1 convention when generating it manually. Both of those
> are cumbersome and hard to remember.

Usually you need to rename old directory to something like:
> myapp.old
and then run 'diff -u3 myapp.old myapp'

No prefixes are added, and patch.py is smart enough to detect that
there is no myapp.old and apply patch to the myapp/ directory
(well, actually you need to make sure that myapp.old does not exist
for patch.py to find myapp/).

> IOW, you're assuming that a 'real patch' has no prefix, and a 'git
> patch' has useless a/ and b/ prefixes. But that relies on a certain
> convention about a 'real patch' which isn't true in the Linux community.

Yes, I want to know about those prefixes in Linux community, because
I developed this tool on Windows and test database doesn't have any
samples.

>> How do you use patch.py?
>
> We use it to apply patches within the backport project, those patches
> are stored in the project and applied against upstream Linux code.

Yes. I've seen that. =)

https://code.google.com/p/python-patch/wiki/Adoptions

I more interested in complete like session recorded session, like
standing behind the shoulder and watching, so that I can think on how
to make patch.py usage more natural, rather than trying to instruct
people how to use. But that's ideal case. I think that an exemplary
shell session where the annoyance benefits itself would suffice.

> Again, you're assuming that the 'canonical patch' should have no
> prefixes. This is simply a matter of convention (whether -p0 or -p1 is
> preferred by the project when applying a patch), and that convention
> happens to be -p1 for many projects. You're assuming -p0.

I understood that you're using git. I don't know how it works, so I need
some data..
Do you use 'git apply'?
Do you use 'git apply -p1` for git patches? (with a/ b/ prefixes)
Do you use 'git apply -p1` for non-git diffs? (without a/ b/ prefixes)

> Anyway, since the current version of patch.py does what we need, there's
> little incentive for us to update/change things. If you consider a
> 'canonical patch' to be -p0, we'll just keep our changed copy :)

I am interested to make patch.py user experience as easy as I can,
and maintaining changed copy is not a really good ux for me. =) And
I am also interested to investigate the nature of those prefixes that I
don't know about.
-- 
anatoly t.
