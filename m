Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48778 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdJMI4N (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 04:56:13 -0400
Message-ID: <1507884971.2551.34.camel@sipsolutions.net> (sfid-20171013_105614_526461_57020383)
Subject: Re: [PATCH 4/5] backports: add bin2hex()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 10:56:11 +0200
In-Reply-To: <8f8b0780-b14e-4795-94ff-6d55f1541c19@broadcom.com> (sfid-20171013_105521_852219_E8C86D05)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <20171012210025.7490-4-johannes@sipsolutions.net>
         <8f8b0780-b14e-4795-94ff-6d55f1541c19@broadcom.com>
         (sfid-20171013_105521_852219_E8C86D05)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-10-13 at 10:55 +0200, Arend van Spriel wrote:
> On 12-10-17 23:00, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> 
> any remark why/who needs this. The change summary hints that it is 
> needed for kernels before 3.18.

Sorry. Key stuff in the next patch requires it :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
