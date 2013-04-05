Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42043 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161416Ab3DECqZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Apr 2013 22:46:25 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so3298347lbh.4
        for <backports@vger.kernel.org>; Thu, 04 Apr 2013 19:46:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365127487-30058-2-git-send-email-andy@greyhouse.net>
References: <1365127487-30058-1-git-send-email-andy@greyhouse.net> <1365127487-30058-2-git-send-email-andy@greyhouse.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 4 Apr 2013 19:46:03 -0700
Message-ID: <CAB=NE6W=jxCkbUoLOMEV-G+H=tcgMFeP0GBzmowB+O019KFUpQ@mail.gmail.com> (sfid-20130405_044628_682862_FAA5DE26)
Subject: Re: [PATCH 2/2] more symbol fixup needed for latest RHEL6.3 kernels
To: Andy Gospodarek <andy@greyhouse.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 4, 2013 at 7:04 PM, Andy Gospodarek <andy@greyhouse.net> wrote:
> These changes will allow compat.ko to load properly on the latest released
> RHEL6.3 errata kernels.
>
> Reported here: https://bugzilla.kernel.org/show_bug.cgi?id=55971
>
> Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

Thanks! Can you port these over to Johannes' backports tree ? I've
frozen development on compat / compat-drivers as we transition over. I
will be sure to merge fixes for stable releases that were already
depending on compat / compat-drivers, these however seem to be
development window fixes.

  Luis
