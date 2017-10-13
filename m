Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:46221 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdJMIzV (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 04:55:21 -0400
Received: by mail-qk0-f174.google.com with SMTP id k123so4192768qke.3
        for <backports@vger.kernel.org>; Fri, 13 Oct 2017 01:55:20 -0700 (PDT)
Subject: Re: [PATCH 4/5] backports: add bin2hex()
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20171012210025.7490-1-johannes@sipsolutions.net>
 <20171012210025.7490-4-johannes@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8f8b0780-b14e-4795-94ff-6d55f1541c19@broadcom.com> (sfid-20171013_105527_047113_1769F3BF)
Date: Fri, 13 Oct 2017 10:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <20171012210025.7490-4-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12-10-17 23:00, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>

any remark why/who needs this. The change summary hints that it is 
needed for kernels before 3.18.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
