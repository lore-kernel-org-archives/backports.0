MIME-Version: 1.0
In-Reply-To: <50B8C4ED.3000609@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
	<1354202681-11787-6-git-send-email-hauke@hauke-m.de>
	<CAFub=KRsvwuXYa8EtMpm7hLgW+hgahP5mUhN2UWFBvxhBXXMeA@mail.gmail.com>
	<50B8C4ED.3000609@hauke-m.de>
Date: Fri, 30 Nov 2012 10:47:40 -0800
Message-ID: <CAB=NE6UdyPL2JRhst3Go7gtooAeVDPLZ+6kDsjV3tFS+unN44A@mail.gmail.com>
Subject: Re: [PATCH 5/5] compat-drivers: do not apply patches in natural sort order
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>,
	backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Nov 30, 2012 at 6:38 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 11/30/2012 08:58 AM, Ozan =C3=87a=C4=9Flayan wrote:
>> On Thu, Nov 29, 2012 at 5:24 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote=
:
>>> Without this patch the patches are applied in the natural sort order of
>>> numbers, which caused this order for patches/network/:
>>> patches/network/0001-netdev_ops.patch
>>> patches/network/02-ksize.patch
>>> patches/network/0002-net-misc.patch
>>> patches/network/0003-netdev-needed_headroom_tailroom.patch
>>> patches/network/03-rfkill.patch
>>> patches/network/04-netns.patch
>>> patches/network/0004-wext-namespace.patch
>>> patches/network/0005-netlink-portid.patch
>>> patches/network/05-usb.patch
>>
>> Actually it was me who changed/broke this and I really can't decide
>> now which one is more intuitive.
>>
>> commit 46a5aef05b92a2162150326f426bebe3541d6e8c
>> Author: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
>> Date:   Fri Jun 22 16:30:54 2012 +0300
>>
>>     compat-wireless: Naturally sort patch prefixes
>>
>>     Use ls -v to get a naturally sorted list of patches like:
>>
>>     patches/00-vga_switcheroo_client_ops.patch
>>     patches/01-dma_buf_ops-addition.patch
>>     patches/02-revert-vm_mmap.patch
>>     patches/98-pr_fmt.patch
>>     patches/99-change-makefile.patch
>>     patches/9999-FIXME-dont-build-i915-for-i2c-problems.patch
>>
>>     instead of:
>>
>>     patches/00-vga_switcheroo_client_ops.patch
>>     patches/01-dma_buf_ops-addition.patch
>>     patches/02-revert-vm_mmap.patch
>>     patches/98-pr_fmt.patch
>>     patches/9999-FIXME-dont-build-i915-for-i2c-problems.patch
>>     patches/99-change-makefile.patch
>>
>>     Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
>>     Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
>
> Hi Ozan,
>
> I missed looking which commit introduced this, I thought it was there
> for ever. With ls -v the prefixes 0005 and 05 are the same and the
> ordering is done by the following characters, this is the reason
> 04-netns.patch is in front of 0004-wext-namespace.patch, but
> 0005-netlink-portid.patch is in front of 05-usb.patch.
>
> For your use case adding the -v is a good option, but as we now have
> some patches with four digits and some with two digits I think the
> version without the -v is the better option, or we rename the patches to
> one common pattern.

Or we can stuff the additional 4 digit patches into a new directory, I
have some patch I am working on that does something like this, let me
know if this is a preferred strategy. So far I have a patch that for
example moves patches under patches/ to patches/collateral-evolutions/
and then I stuff the crap/ pending-stable/ linux-next-cherry-picks/
and linux-next-pending/ into patches/ as well. If we separate the 4
digit patches from the not-so-cleaned up series of older patches for
backporting its unclear to me what we'd call the newer ones if we take
this approach. Thoughts?

  Luis
