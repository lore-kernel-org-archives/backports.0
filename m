Return-path: <backports-owner@vger.kernel.org>
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:59124 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756517AbcCUSKK (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Mar 2016 14:10:10 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 51ED61843F5
	for <backports@vger.kernel.org>; Mon, 21 Mar 2016 18:04:25 +0000 (UTC)
Date: Mon, 21 Mar 2016 14:04:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>,
	Michal Marek <mmarek@suse.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	kconfig-sat@googlegroups.com,
	Till Kamppeter <till.kamppeter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jej B <James.Bottomley@hansenpartnership.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: GSoC project
Message-ID: <20160321140421.16eb099c@gandalf.local.home> (sfid-20160321_191020_442454_9EFD660D)
In-Reply-To: <CAB=NE6XpkkzqtXEAQ_7YyPAAf5NbFun-MWvXz3Q_K6PTPcRKxQ@mail.gmail.com>
References: <CAGZ2q2z5eHwaDqu53oyyKz+ur=TTa1AQrjHT51Tww0wizVz7_A@mail.gmail.com>
	<alpine.DEB.2.10.1603140956030.2688@hadrien>
	<CAGZ2q2ypy+N_UPPwo=XOOiB2h+tV1vhEyFR2dwex6i9vAJboAQ@mail.gmail.com>
	<CAB=NE6XpkkzqtXEAQ_7YyPAAf5NbFun-MWvXz3Q_K6PTPcRKxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 21 Mar 2016 10:36:23 -0700
"Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> On Mar 20, 2016 2:04 PM, "Cristina-Gabriela Moraru"
> <cristina.moraru09@gmail.com> wrote:
> >
> > 2016-03-14 10:56 GMT+02:00 Julia Lawall <julia.lawall@lip6.fr>:  
> > >
> > >
> > > On Sat, 12 Mar 2016, Cristina-Gabriela Moraru wrote:
> > >  
> > >> Hi,
> > >>
> > >> My name is Cristina Moraru and I am a software engineer from Romania
> > >> currently a student in a Master's program. I am interested in Driver
> > >> Backports project from GSoC and I would like to familiarize with it
> > >> and start contributing. My experience so far with Linux Kernel
> > >> includes an university course of driver development and an internship
> > >> at The Linux Foundation within Outreachy program (December 2015-March
> > >> 2016) in which I developed drivers in the Industrial I/O subsystem. I
> > >> have checked the TODO's page and I think the most interesting idea is
> > >> adding make localmodconfig support. Any suggestion of what to start
> > >> with ?  

Ah, this explains why I was on the Cc list :-) (I'm the original author
of the localmodconfig code).

Just some history. "localmodconfig" was a standalone project for some
time called "streamline_config.pl" that I wrote in 2005, because I was
working on lots of machines and had to constantly try to minimize the
config setup for each one. I got a new box to work on once a month and
this process was annoying enough to automate it.

I still have a link to the code that was out of tree:

 http://rostedt.homelinux.com/code/streamline_config.pl

Finally, I think it was around 2009 where Linus Torvalds gave a rant at
a Kernel Summit about non-kernel-developers having to do git bisects,
and it taking too much time because they only had distribution configs.
He said we needed a tool to shrink down the config for these users.
That's when Thomas Gleixner told him about my tool, as Thomas used it
for his own work. Shortly after that, we worked to get the code working
with the make system, and the rest is history.

Backporting "make localmodconfig" should not be very difficult as it
has existed long before it was introduced into mainline. I'm willing to
help out where I can, but this should be used as an introductory step.
If you can expand on the tool and get it more integrated into existing
drivers, that could be proven very beneficial to mainline.

-- Steve


> > >
> > > Hi,
> > >
> > > Sorry not to have gotten back to you.  I will discuss with Luis about what
> > > we are interested in supervising in the context of GSoC, and get back to
> > > you.
> > >
> > > julia  
> >
> > Hello,
> >
> > Do you have any update ?  
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
