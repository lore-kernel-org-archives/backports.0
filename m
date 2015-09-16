Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18868 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbbIPDhP (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 15 Sep 2015 23:37:15 -0400
Received: from suquasem-mobl1.amr.corp.intel.com (unknown [10.254.177.138])
	by linux.intel.com (Postfix) with ESMTP id BCA7C6A4005
	for <backports@vger.kernel.org>; Tue, 15 Sep 2015 20:36:20 -0700 (PDT)
To: backports@vger.kernel.org
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: parse-integer support
Message-ID: <55F8E3E9.9090901@linux.intel.com> (sfid-20150916_053717_657974_49EDAFEA)
Date: Tue, 15 Sep 2015 22:37:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
I've progressed a bit in my endeavor to backport the sound drivers with 
only a few compilation errors but I've reached a blocking point. The 
audio drivers were converted to use parse_integer this summer but I 
can't figure out how to back port this.

If I add include/linux/parse-integer to copy-list then there are tons of 
redeclations.
If I modify backport/backport-include/linux/kernel.h to add a 
conditional #include <linux/parse-integer.h> then I can't figure out how 
to add a subset of this header file from the backport-include directory.

It's only a matter of time before others are impacted so maybe smarter 
people than me have ideas on how to go about this.
Thanks,
-Pierre
--
To unsubscribe from this list: send the line "unsubscribe backports" in
