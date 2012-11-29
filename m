MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1211292218150.1999@localhost6.localdomain6>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
	<1354144069-28611-4-git-send-email-hauke@hauke-m.de>
	<CAB=NE6Vpqo4D6ieSHpekGkAp1=R+keLA+8x2nrwi7HrycLdUgA@mail.gmail.com>
	<alpine.DEB.2.02.1211292218150.1999@localhost6.localdomain6>
Date: Thu, 29 Nov 2012 13:30:43 -0800
Message-ID: <CAB=NE6V+xVTq7-cx4Y0hqXwhJqW860C-DE4BoWYJh6diOX0C+w@mail.gmail.com>
Subject: Re: [PATCH 3/6] compat-drivers: build RTL8723AE
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org,
	Adrian Chadd <adrian@freebsd.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 29, 2012 at 1:21 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Thu, 29 Nov 2012, Luis R. Rodriguez wrote:
>
>> On Wed, Nov 28, 2012 at 3:07 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>
>>> This driver is building on all supported kernel versions.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>
>>
>> Julia, just a heads up this is the only change that was required to
>> backport one 802.11 driver with the current framework. I don't believe
>> that the change below can be expressed in SmPL nor inferred into SmPL,
>> but wanted to double check with you.
>
>
> Will it be needed to transform other drivers in this way?

Indeed the collection of changes for this collateral evolution is all
present in one patch:

patches/network/11-dev-pm-ops.patch

As it is right now all patches with double digits have not been split
out cleanly to *only* have present *one* collateral evolution. I
started doing this starting with the first series of patches the old
01-netdev-attach-ops.patcha and from this I split it up into four
patches:

0001-netdev_ops.patch
0002-net-misc.patch
0003-netdev-needed_headroom_tailroom.patch
0004-wext-namespace.patch
0005-netlink-portid.patch

So for example 0001-netdev_ops.patch has only one collateral evolution
which I have managed to infer SmPL using spdiff (but not yet
patchparse).

I suspect we can do the same with 11-dev-pm-ops.patch.

> In principle, these changes to data structures should be fine for SmPL.

Sweeeeeeeeeeeeeeet! Adding Adrian for #worlddomination
#killingproprietarydriver plans.

> I think you can even add the #ifdefs.

Mama mia.

> The only thing that does not look good
> to me is that compat_pci_suspend and compat_pci_suspend don't have
> semicolons after them.  Unlike eg module_pci_driver.  Is there any reason
> for this?

Um, well these unwrap to defining either a routine or nothing, so I
think adding one should be OK. I'll test compile that today and if it
works I'll add it.

> I don't think these changes would be inferred by spdiff, because of the
> detail that it only works inside functions.

Thought so, thanks for the confirmation, it clarifies the scope of
work required for these type of collateral evolutions.

  Luis
