Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46105 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdJMI4X (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 04:56:23 -0400
Received: by mail-qt0-f176.google.com with SMTP id 1so18354675qtn.3
        for <backports@vger.kernel.org>; Fri, 13 Oct 2017 01:56:23 -0700 (PDT)
Subject: Re: [PATCH 1/5] backports: move headers to be clearer
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20171012210025.7490-1-johannes@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <353bd455-2253-886a-b0ca-9c3777a739e4@broadcom.com> (sfid-20171013_105625_337302_400551C7)
Date: Fri, 13 Oct 2017 10:56:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171012210025.7490-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 12-10-17 23:00, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Those uapi header files are always needed, so don't mark them as
> being for wwwan drivers.

Just nit picking but your finger seem to have stuck on the 'w' key :-p

Regards,
Arend

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
--
To unsubscribe from this list: send the line "unsubscribe backports" in
