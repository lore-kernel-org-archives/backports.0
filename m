Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41593 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab2JZJ3j convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 26 Oct 2012 05:29:39 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2020700iag.19
        for <backports@vger.kernel.org>; Fri, 26 Oct 2012 02:29:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121025201432.D62E040AC0@repository3.orbit-lab.org>
References: <20121025201432.D62E040AC0@repository3.orbit-lab.org>
Date: Fri, 26 Oct 2012 12:29:38 +0300
Message-ID: <CAFub=KSB7qd7zrin754hPzHNxLHuA2WVm_uxSQRQTgoYXRjAMg@mail.gmail.com>
Subject: Re: Compat-wireless release for 2012-10-25 is baked
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Oct 25, 2012 at 11:14 PM, Compat-wireless cronjob account
<compat@orbit-lab.org> wrote:
> git fetch github (/var/opt/compat/compat-wireless-2.6)
> Nothing new to pack.
> HEAD is now at a26c7c1 compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
> git fetch github (/var/opt/compat/compat)
> Nothing new to pack.
> HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat-kernels
> git fetch  (/var/opt/compat/linux-next)
> Nothing new to pack.
> HEAD is now at 2253213 Add linux-next specific files for 20121025
> Error while updating from wireless-testing
>
> compat-drivers code metrics
>
>    1182719 - Total upstream lines of code being pulled
>
>    network
>    ----------------------------------------

can this be caused by the change that I've introduced to admin-update.sh?


-- 
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
