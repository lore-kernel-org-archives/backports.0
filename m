Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52866 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964822Ab2JZPxV (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 26 Oct 2012 11:53:21 -0400
Message-ID: <508AB1E3.8030303@hauke-m.de>
Date: Fri, 26 Oct 2012 17:53:07 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
CC: backports@vger.kernel.org
Subject: Re: Compat-wireless release for 2012-10-25 is baked
References: <20121025201432.D62E040AC0@repository3.orbit-lab.org> <CAFub=KSB7qd7zrin754hPzHNxLHuA2WVm_uxSQRQTgoYXRjAMg@mail.gmail.com>
In-Reply-To: <CAFub=KSB7qd7zrin754hPzHNxLHuA2WVm_uxSQRQTgoYXRjAMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/26/2012 11:29 AM, Ozan Çağlayan wrote:
> On Thu, Oct 25, 2012 at 11:14 PM, Compat-wireless cronjob account
> <compat@orbit-lab.org> wrote:
>> git fetch github (/var/opt/compat/compat-wireless-2.6)
>> Nothing new to pack.
>> HEAD is now at a26c7c1 compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
>> git fetch github (/var/opt/compat/compat)
>> Nothing new to pack.
>> HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat-kernels
>> git fetch  (/var/opt/compat/linux-next)
>> Nothing new to pack.
>> HEAD is now at 2253213 Add linux-next specific files for 20121025
>> Error while updating from wireless-testing
>>
>> compat-drivers code metrics
>>
>>    1182719 - Total upstream lines of code being pulled
>>
>>    network
>>    ----------------------------------------
> 
> can this be caused by the change that I've introduced to admin-update.sh?
> 
> 

The patches do not apply any more and then we get such a mail. I do not
think this was caused by your patch for the code metrics.

Hauke
