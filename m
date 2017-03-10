Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34760 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935818AbdCJJxe (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Mar 2017 04:53:34 -0500
Received: by mail-qk0-f179.google.com with SMTP id p64so159817139qke.1
        for <backports@vger.kernel.org>; Fri, 10 Mar 2017 01:53:33 -0800 (PST)
Subject: Re: [PATCH 3/4] backports: introduce new definition for DECLARE_EWMA
 macro
To: Johannes Berg <johannes@sipsolutions.net>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
 <1489064253-3652-4-git-send-email-arend.vanspriel@broadcom.com>
 <1489127774.3038.1.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d639368b-b887-cd0b-9c51-b76f127407f4@broadcom.com> (sfid-20170310_105351_624121_46EB4DDA)
Date: Fri, 10 Mar 2017 10:53:30 +0100
MIME-Version: 1.0
In-Reply-To: <1489127774.3038.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10-3-2017 7:36, Johannes Berg wrote:
> On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
>> Since commit eb1e011a1474 ("average: change to declare precision,
>> not factor") the definition of DECLARE_EWMA has changed so we
>> need a backport for the new macro as it differs. Changing the
>> strategy by checking the kernel version and #undef the macro to
>> be sure we do not run into macro redefinition issue.
> 
> Good one. However, why not just add this file to copy-list and be done
> with it? That way, the original one from the kernel will never be
> included at all and we'll always have the right version. Not that I
> think we'll change it much, but why not make it easier?

That will work as long a linux/average.h only contains DECLARE_EWMA and
that is all the backported code cares about. So for now the copy-list
approach will work. Maybe add a comment in the copy-list documenting the
approach.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
