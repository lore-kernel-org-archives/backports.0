Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49675 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934530Ab2JYPLa (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 25 Oct 2012 11:11:30 -0400
Message-ID: <50895699.6060009@hauke-m.de>
Date: Thu, 25 Oct 2012 17:11:21 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
CC: backports@vger.kernel.org
Subject: Re: Compat-wireless release for 2012-10-24 is baked
References: <20121024201437.368EB40ABF@repository3.orbit-lab.org> <CAFub=KTgcjeNuL6T3aoV8g3pd4GeQu6QboUeNEMTjcRcq5Ji_w@mail.gmail.com>
In-Reply-To: <CAFub=KTgcjeNuL6T3aoV8g3pd4GeQu6QboUeNEMTjcRcq5Ji_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/25/2012 04:57 PM, Ozan Çağlayan wrote:
> On Wed, Oct 24, 2012 at 11:14 PM, Compat-wireless cronjob account
> <compat@orbit-lab.org> wrote:
>> git fetch github (/var/opt/compat/compat-wireless-2.6)
>> HEAD is now at a26c7c1 compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
>> git fetch github (/var/opt/compat/compat)
>> Nothing new to pack.
>> HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat-kernels
>> git fetch  (/var/opt/compat/linux-next)
>> Nothing new to pack.
>> HEAD is now at d1298f5 Add linux-next specific files for 20121024
>> Error while updating from wireless-testing
> 
> Do we have the code of these cron scripts anywhere on the net? Would
> you consider to run bin/get-compat-trees before running this script to
> fetch the latest kernels?

Hi Ozan,

The code of the scripts is here:
https://git.kernel.org/?p=linux/kernel/git/mcgrof/compat-user.git;a=summary

Doesn't get-compat-trees need root rights? If so then I do not think it
is a good idea to run that automatically, but we should test against
some more recent kernels.

Hauke
