Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <julia.lawall@lip6.fr>
Date: Fri, 2 Nov 2012 10:48:30 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    Stephen Rothwell <sfr@canb.auug.org.au>,
    Konstantin Ryabitsev <mricon@kernel.org>,
    "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Expressing linux-next collateral evolutions in formal grammar
In-Reply-To: <CAB=NE6Xv5Lag0J2U3CHK9huzMQLyJEZmdrcqWWomn48w=xUnag@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211021045200.2014@localhost6.localdomain6>
References: <CAB=NE6Xv5Lag0J2U3CHK9huzMQLyJEZmdrcqWWomn48w=xUnag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <backports@vger.kernel.org>

> The way I would envision this to be easier to manage is to break them
> down by subsystem and the reviewer can then go and read the grammar
> for their own subsystem of preference. The long term benefit of this
> is that even if folks don't use SmPL for collateral evolutions we have
> a possibility here of being able to backport a collateral evolution by
> using the inverse of the SmPL grammar, if we can get to the point of
> coming up with formal and proper grammar on each collateral evolution.
>
> Thoughts?

I had liked the idea of lwn, because that makes it public but doesn't 
bother anyone.  But another option would be to just send an email to the 
relevant maintainer?  Perhaps it would be better to send the email just 
to the specific maintainer for the file, and not all the way up the 
maintainer hierarchy, because these would be just suggestions of things to 
look at, and not actual patch proposals.

thanks,
julia
