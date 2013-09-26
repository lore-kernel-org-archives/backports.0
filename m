Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63361 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab3IZThi (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 26 Sep 2013 15:37:38 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so6686800wgh.0
        for <backports@vger.kernel.org>; Thu, 26 Sep 2013 12:37:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130910232712.GC14238@shaftnet.org>
References: <522C9ADF.1020809@hauke-m.de> <20130910232712.GC14238@shaftnet.org>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 26 Sep 2013 12:37:16 -0700
Message-ID: <CAB=NE6VR2hP3vYjSzwtChKVbpXC6uF4KPhaC+2DLXQ_EftpQ0Q@mail.gmail.com> (sfid-20130926_213740_643163_E0804152)
Subject: Re: Removing of GPU drivers from backports
To: Solomon Peachy <pizza@shaftnet.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Sep 10, 2013 at 4:27 PM, Solomon Peachy <pizza@shaftnet.org> wrote:
> On Sun, Sep 08, 2013 at 05:42:23PM +0200, Hauke Mehrtens wrote:
>> As we do not have that big constant man power I am for removing the GPU
>> drivers to make it easier to add support for a new linux next versions.
>> Most of the users are using backports to get a recent wireless driver
>> for their desktop Linux or their (old) Linux on an embedded device.
>
> For what it's worth, I agree.
>
> I simply don't understand who the target audience is for the GPU/DRM
> driver backports; unlike the wireless/network drivers, the GPU/DRM
> subsystem generally requires equally updated userspace in order to take
> advantage of the newer stuff, and that has its own morass of
> dependencies.

GPU driver addition started from a GSoC project but its main author is
busy with other things. As per the talks on backports at LinuxCon I'm
fine with removing GPU drivers given we have not found a maintainer
for them nor have Linux Distributions stepped up to help with that.
I'm happy to remove things unless we get folks starting to take more
responsibility over their backports.

We should also only support the latest say, 25 kernels, and stick at that.

That said, patches welcomed to remove ancient kernels then, and Hauke
already sent an RFC to remove GPU, that can be respinned as PATCH form
and I'll take it.

> I don't understand the point of backported regulator drivers either;
> those tend to be part of the core board support package for a given
> hardware/SoC design and as such isn't something that's going to be
> retrofitted into an existing design running an older kernel; and if
> you're going to be bringing up a new board from scratch, why not use the
> latest kernel to begin with?

The idea with that is to provide in-kernel backport support. That
opens a new way of supporting backports. I'll be addressing this later
in October.

  Luis
