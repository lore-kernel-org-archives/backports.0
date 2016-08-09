Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36203 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcHIGzA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Aug 2016 02:55:00 -0400
MIME-Version: 1.0
In-Reply-To: <20160808191533.GT3296@wotan.suse.de>
References: <1469979232-15531-1-git-send-email-cristina.moraru09@gmail.com>
 <1469979232-15531-3-git-send-email-cristina.moraru09@gmail.com> <20160808191533.GT3296@wotan.suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Aug 2016 08:54:58 +0200
Message-ID: <CAMuHMdWB0f2HHtOrcL2ceQxj3sEmcHzR7vFRkK90e39jYE=4fQ@mail.gmail.com> (sfid-20160809_085502_980507_712BF966)
Subject: Re: [RFC PATCH 2/3] Add generation of Module.ksymb file in streamline_config.pl
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	backports@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
	Michal Marek <mmarek@suse.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	"rafael.j.wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 8, 2016 at 9:15 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Sun, Jul 31, 2016 at 05:33:51PM +0200, Cristina Moraru wrote:
>> Add generation of ./scripts/mod/Module.ksymb file containing
>> associations of driver file names and corresponding CONFIG_*
>> symbol.
>>
>> This file will be used by modpost to peg kconfig CONFIG_*
>> symbol to its corresponding module. This information will
>> be further exposed in userspace for extracting build options
>> for the required modules.
>>
>> This approach faces the following limitations:
>> * in some cases there are more than one CONFIG_* option
>> for certain objects. This happens for the objects that are
>> part of more CONFIGs. Thus, all configs are returned for
>> this object names. For example, the mapping for clk_div6 is
>> CONFIG_ARCH_R8A73A4, CONFIG_ARCH_R8A7793 and many others.
>
> Ah, indeed so for instance:
>
> drivers/clk/renesas/Makefile:
> ...
> obj-$(CONFIG_ARCH_R8A73A4)              += clk-r8a73a4.o clk-div6.o
> obj-$(CONFIG_ARCH_R8A7740)              += clk-r8a7740.o clk-div6.o
> ...
>
> So in this case there is no particular unique CONFIG_* symbols that
> only associates itself to clk-div6.
>
> Given that the purpose here is to help compile a .config that is sufficient to
> build a kernel with that module, I do believe using both config symbols would
> be the appropriate solution in this case to ensure a build suffices based only
> on this information.  This is only possible of course *iff* both symbols are
> not mutually exclusive, so in this case an issue would be if for instance
> CONFIG_ARCH_R8A73A4's kconfig entry negates CONFIG_ARCH_R8A7740. They do not
> in this case so using both suffices. I can imagine doing this secondary logic
> is cumbersome, so perhaps its best we avoid these sorts of situations as it
> would imply doing more work going barkwards -- from modules loaded to modules
> to symbols.
>
> I'd bet this would not be the only kconfig issue that could arise from this
> loose practice in kconfig.
>
> Anyway, if we determine that both kconfig options should be enabled for a build
> to select this driver -- that would increase the build size, perhaps with no
> need for it. So this strategy of course would not yield optimal builds. So we
> should just expand the kconfig documentation indicating pitfalls of this use
> of kconfig, given the deterministic gains we want of mapping between modules
> to config symbols.

If you would not only look at loaded modules, but also at the compatible
values in the DTB, you could find out which of the two symbols is needed.

E.g. on r8a7740, you would discover that you need clk-r8a7740, hence
enable CONFIG_ARCH_R8A7740, which also build clk-div.o.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe backports" in
