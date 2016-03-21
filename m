Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51907 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757132AbcCURgs (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Mar 2016 13:36:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAGZ2q2ypy+N_UPPwo=XOOiB2h+tV1vhEyFR2dwex6i9vAJboAQ@mail.gmail.com>
References: <CAGZ2q2z5eHwaDqu53oyyKz+ur=TTa1AQrjHT51Tww0wizVz7_A@mail.gmail.com>
 <alpine.DEB.2.10.1603140956030.2688@hadrien> <CAGZ2q2ypy+N_UPPwo=XOOiB2h+tV1vhEyFR2dwex6i9vAJboAQ@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Mon, 21 Mar 2016 10:36:23 -0700
Message-ID: <CAB=NE6XpkkzqtXEAQ_7YyPAAf5NbFun-MWvXz3Q_K6PTPcRKxQ@mail.gmail.com> (sfid-20160321_183713_854789_2769BD19)
Subject: Re: GSoC project
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Michal Marek <mmarek@suse.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	kconfig-sat@googlegroups.com,
	Till Kamppeter <till.kamppeter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jej B <James.Bottomley@hansenpartnership.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mar 20, 2016 2:04 PM, "Cristina-Gabriela Moraru"
<cristina.moraru09@gmail.com> wrote:
>
> 2016-03-14 10:56 GMT+02:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Sat, 12 Mar 2016, Cristina-Gabriela Moraru wrote:
> >
> >> Hi,
> >>
> >> My name is Cristina Moraru and I am a software engineer from Romania
> >> currently a student in a Master's program. I am interested in Driver
> >> Backports project from GSoC and I would like to familiarize with it
> >> and start contributing. My experience so far with Linux Kernel
> >> includes an university course of driver development and an internship
> >> at The Linux Foundation within Outreachy program (December 2015-March
> >> 2016) in which I developed drivers in the Industrial I/O subsystem. I
> >> have checked the TODO's page and I think the most interesting idea is
> >> adding make localmodconfig support. Any suggestion of what to start
> >> with ?
> >
> > Hi,
> >
> > Sorry not to have gotten back to you.  I will discuss with Luis about what
> > we are interested in supervising in the context of GSoC, and get back to
> > you.
> >
> > julia
>
> Hello,
>
> Do you have any update ?

Cc'ing the kconfig-sat list as well.

Sorry for the delay. I can certainly mentor you on the localmodconfig
support for backports. You actually may be able to get this done fast
though, so I'd like you to also think a bit also about perhaps
expanding this to something a bit ambitious should you have more time
or want to really extend your work to be useful outside of the context
of just backporting.

For instance, the Linux kernel upstream 'make localmodconfig' has some
issues, and adding support for 'make localmodconfig' support on
backports may actually fill in some gaps that may help upstream.
Although Linux backports helps complement Linux upstsream, Linux
upstream historically has not needed to care about older kernels other
than to ensuring we don't break ABIs, but since the work you do helps
identify what backported drivers you need you're essentially
attempting to resolve the question of 'what old drivers do I have
enabled on old kernel X which I actually need in a new kernel Y?'
While addressing this question is very backports specific, it also has
an application upstream as well: it could mean leveraging the same
solution on Linux upstream. When you download the latest kernel you
are essentially asking the very same exact question, only we don't
address this right now through 'make localmodconfig'. Because of this,
it also makes sense to see if we can come up with a reasonable
compromise which might actually help address this upstream as an
optional enhancement, somehow -- with either a map or perhaps some
optional driver annotations. Historically Linux upstream has not cared
about backporting, but through the years we've identified a few
changes in coding practices that may help make Linux backporting more
automatic and safe, given the gains, we've already started to slowly
justify some changes upstream to help with this. I'm not saying it is
a requirement and we are sure we will do upstream changes to help with
this problem, I am saying we should keep an open mind about that
possibility.

As another example, in terms of backports you also have some
situations where a user is using an old distro kernel which lacks a
driver to support a piece of hardware only available on future
kernels, the backports project would carry a driver which would enable
such piece of hardware without requiring the user to upgrade the full
kernel. In these cases 'make localmodconfig' on Linux upstream should
have have no heuristics currently available that help it identify that
a new driver can help support your old piece of hardware, as it really
only relies on your currently loaded set of modules. Resolving this
gap clearly is not only something applicable to Linux backports, it
can be used upstream as well.

For your project I'd like to recommend you consider studying the core
basic driver model, in particular you can study these things from
Linux upstream sources:

Documentation/kobject.txt
Documentation/kref.txt
Documentation/driver-model/

To extend your project in more challenging and interesting ways you
may want to start think about how to project current available set of
output from bus / standard tools (lspci, lsusb, dmidecode, acpidump)
onto an existing kernel .config / Kconfig language, and perhaps maps
between old kernels and new kernels. One thing you can take into
consideration that may help for more ambitious goals is knowing that
the prospect of kconfig getting SAT solver support may soon be reality
thanks to the work of a quite a bit of people [0], and if you want to
project your own goals with a SAT solver already in place it means the
set of toolbox available for your solution to the problems you need to
address grows. Doing this means you'd be projecting either future
goals or other building your own solution on a piece of technology
which may soon be able to reap benefit from. This is good for both
short term and long term. Its good for the short term so you think
outside the box, and gets you thinking of the larger picture, for the
long term it may extend the goals of your own work in alignment with
future technology we may have.

[0] http://kernelnewbies.org/KernelProjects/kconfig-sat

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
