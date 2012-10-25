Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46462 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759662Ab2JYO57 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 25 Oct 2012 10:57:59 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1349029iag.19
        for <backports@vger.kernel.org>; Thu, 25 Oct 2012 07:57:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121024201437.368EB40ABF@repository3.orbit-lab.org>
References: <20121024201437.368EB40ABF@repository3.orbit-lab.org>
Date: Thu, 25 Oct 2012 17:57:58 +0300
Message-ID: <CAFub=KTgcjeNuL6T3aoV8g3pd4GeQu6QboUeNEMTjcRcq5Ji_w@mail.gmail.com>
Subject: Re: Compat-wireless release for 2012-10-24 is baked
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Oct 24, 2012 at 11:14 PM, Compat-wireless cronjob account
<compat@orbit-lab.org> wrote:
> git fetch github (/var/opt/compat/compat-wireless-2.6)
> HEAD is now at a26c7c1 compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
> git fetch github (/var/opt/compat/compat)
> Nothing new to pack.
> HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat-kernels
> git fetch  (/var/opt/compat/linux-next)
> Nothing new to pack.
> HEAD is now at d1298f5 Add linux-next specific files for 20121024
> Error while updating from wireless-testing

Do we have the code of these cron scripts anywhere on the net? Would
you consider to run bin/get-compat-trees before running this script to
fetch the latest kernels?


-- 
Ozan Çağlayan
